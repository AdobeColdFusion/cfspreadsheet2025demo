<cfscript>
    obj = createObject("component","spreadsheets");
    invoke(obj,"editCSV",{fileName = form.filetoview});
</cfscript>