<cfscript>
    // Pass-through CFM to display the contents of a CSV in table format
    obj = createObject("component","spreadsheets"); // Instantiate our component
    invoke(obj,"displayDataAsTable",{fileName = form.filetoview}); // Invoke the table display and pass in the form field for which file to view
</cfscript>