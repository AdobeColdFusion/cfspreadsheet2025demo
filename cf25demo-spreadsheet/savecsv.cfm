<cfscript>
    obj = createObject("component","spreadsheets");
    invoke(obj,"savecsv",{csvtext = form.csvtext,csvname = form.csvname});
</cfscript>