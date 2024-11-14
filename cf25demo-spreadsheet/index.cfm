<!DOCTYPE html>
<html lang="en">
<head>
    <title>Adobe ColdFusion 2025 - CSV Demo App</title>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css">
    <style>
        body {
            padding: 30px;
        }
        
        .full-width-scroll {
            width: 100%;
            overflow: scroll;
        }
        .h350px {
            height: 350px;
        }
        .textarea {
            width: 100%;
            height: 100px;
        }
        .textareaedit {
            width: 100%;
            height: 250px;
        }
    </style>
</head>
    <body hx-trigger="load" hx-get="displayfiles.cfm" hx-target="#filescontainer">
        <h1 class="is-size-2">CSV Manager</h1>
        <div class="block">&nbsp;</div>
        <button class="button is-primary" hx-get="displayfiles.cfm" hx-target="#filescontainer">VIEW CSVs</button>
        <button class="button is-primary" hx-get="createcsv.cfm" hx-target="#filescontainer">CREATE CSV</button>
        <button class="button is-primary" hx-get="editcsv.cfm" hx-target="#filescontainer">EDIT CSV</button>
        <button class="button is-primary" hx-get="searchcsv.cfm" hx-target="#filescontainer">SEARCH CSV</button>
        <div class="block">&nbsp;</div>
        <div id="filescontainer" class="full-width-scroll h350px box">
        </div>
        
        <div id="viewcontainer" class="full-width-scroll h350px box"></div>
    </body>
<script src="https://unpkg.com/htmx.org@2.0.0"></script>
<script>
function clearDivContainer(divid){
    document.getElementById(divid).innerHTML = "";
}
</script>
</html>