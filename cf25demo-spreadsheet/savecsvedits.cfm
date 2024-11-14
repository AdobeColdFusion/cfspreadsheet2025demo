<cfscript>
    obj = createObject("component","spreadsheets");
    invoke(obj,"saveeditcsv",{csvtext = form.csvtext,csvname = form.filename});
</cfscript>