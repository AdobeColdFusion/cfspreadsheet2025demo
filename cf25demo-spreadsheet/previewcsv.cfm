<cfscript>
    obj = createObject("component","spreadsheets");
    invoke(obj,"previewcsv",{csvtext = form.csvtext,csvname = form.csvname});
</cfscript>