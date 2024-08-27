def calculate_sessions(values):
    reduce(values) as $item (
        {min_ts: null, max_ts: null, purchase_session: false};
        if (.min_ts == null) then .min_ts = $item.unix_ts end
        | .max_ts = $item.unix_ts
        | if ($item.type == "placed_order") then .purchase_session = true else .purchase_session = .purchase_session end
        | {
            customer_id: $item.event."customer-id",
            session: $item.session,
            min_ts: .min_ts,
            max_ts: .max_ts, 
            ts_diff: (.max_ts - .min_ts),
            purchase_session: .purchase_session
        }
    );

def sessionize(values):
    group_by( .event."customer-id" )
    | map( group_by( .session ) )
    | map( map ( calculate_sessions( .[] ) ) )
    ;

def calculate_duration(values):
    foreach(values) as $item (
        {durations: [], time: 0, any: false};
        if ($item.purchase_session == true) then .durations += [.time] | .any = true
            else .time += $item.ts_diff
        end;
        if .any then .durations else empty end
    )
    ;

def median(values):
    sort
    | if length % 2 == 0 then (.[length / 2 - 1] + .[length / 2]) / 2
        else .[length / 2]
    end
    ;

def median_visits_before_order:
    sessionize( . )
    | map ( select ( .[].purchase_session == true ) | map ( select( .purchase_session == true ) ) )
    | reduce .[][] as $item ([]; . += [( $item.session )] )
    | median( . )
    ;

def median_session_duration_before_order:
    sessionize( . )
    | map ( select ( .[].purchase_session == true ) )
    | map( calculate_duration( .[] ) )
    | reduce .[] as $item ( []; . += ($item | flatten ) )
    | median( . )
    | . / 60
    ;
