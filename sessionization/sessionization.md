# Sessionization

You might remember the sessionization assignment we do for our assessments, but just to refresh your memory. We have our super real webshop which generates webdata. Upper management wants some insights and they want it now, you know how that goes. The endgoal is to have two metrics:
- Median sessions before order
- Median time spent on the website before an order

There's a few steps than we have to take to make it work.

### Setup

First we need to retrieve the jq setup. The zipfile will be shared on basecamp so you can retrieve it from there.
The zip contains two .jq files and a folder with tests as well as a taskfile in the root and in the tests folder.
For the exercise there's two ways to go about it: 
1. You can follow the setup given in the zip. This means using the templates and filling in the functions.
You can use the Taskfile to run the tests by running ```task tests:run-tests tests=%TESTNAME```. 
The root Taskfile also contains a bunch of tasks to run the files themselves and save the output.
Please take a look at what the Taskfiles do to make sure you know what happens.
2. Build your own implementation from the ground up, this will be harder but you can do your own thing.

Either way is fine, so feel free to pick what you want.
Second we need to get the data. The data can be found [here](https://storage.googleapis.com/xcc-de-assessment/events.json), but you can also use the download_data task.
In order to work with the data for the first approach you should create a folder called data and store the data there as ```events.json```.

### Hints

- To read the data --slurp is very useful, take a look at the [manual](https://jqlang.github.io/jq/manual/#invoking-jq).
- Time calculations with .jq kinda suck, but there might a format that's more suitable...
- [Foreach](https://jqlang.github.io/jq/manual/#foreach) is very useful
- Similarly map, reduce, groupby and to_entries might prove useful
- Think about the way data should be shaped to make it workable
- Keep in mind some of the scenarios that can happen in the data
