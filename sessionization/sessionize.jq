def window(values):
    if (length == 1) then [ values ]
    else foreach(values | [.]) as $item (
        {items: [], ready: false};
        if (.ready | not) then .items
            elif $item == null then []
            else .items[-1:]
        end
        | . + $item
        | { items: ., ready: (length == 2 or ($item == null and length > 0)) };
        if .ready then .items else empty end
    )
    end;

def parse_time(time):
    time
    | split(".")[0] 
    | strptime("%Y-%m-%dT%H:%M:%S")
    | mktime 
    ;

def calculate_sessions(values; $seconds):
    if (length == 1) then .[][0] += { "new_session": 1 } | .[]
    else to_entries
    | map(
        .value[1] += { "new_session": ( if .value[1].unix_ts - .value[0].unix_ts > $seconds then 1 else 0 end  ) }
        | if .key == 0 then .value[0] += { "new_session": 0 }
        else del(.value[0] ) 
        end
        | .value[]
    )
    end;

def cumsum(values; $column):
    foreach(values) as $item (
        {session: 0};
        .session += $item.[$column]
        | $item + {"session": .session};
        .
    );

def sessionize:
    map( select( .event."customer-id" ) ) 
    | group_by( .event."customer-id" )
    | map( 
        map( . + {"unix_ts": parse_time( .event.timestamp ) } )
        | sort_by( .unix_ts )
        | [ window( .[] ) ]
        | calculate_sessions( .; 600 )
        | cumsum( .[]; "new_session" )
        | del( .new_session )
    );
