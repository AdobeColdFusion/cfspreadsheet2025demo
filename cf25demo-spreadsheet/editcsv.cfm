<h1 class="is-size-4">Edit CSVs</h1>
<cfscript>
    // This file is loaded to display the contents of the data directory, which are CSVs
    obj = createObject("component","spreadsheets");
    invoke(obj,"displayDataFilesForEdit");
</cfscript>