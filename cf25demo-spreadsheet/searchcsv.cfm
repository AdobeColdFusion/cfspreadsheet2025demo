<h1 class="is-size-4">Search CSVs</h1>
<script>clearDivContainer("viewcontainer");</script>
<cfscript>
    // This file is loaded to display the contents of the data directory, which are CSVs
    obj = createObject("component","spreadsheets");
    invoke(obj,"displayDataFilesForSearch");
</cfscript>