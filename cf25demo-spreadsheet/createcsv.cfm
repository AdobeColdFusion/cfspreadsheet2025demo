<h1 class="is-size-4">Create CSV</h1>
<form>
<strong>CSV Name (no extension)</strong><br />
<input type="text" name="csvname" id="csvname" value="" class="input" />
<br />
<strong>CSV Text (must be valid)</strong><br />
<textarea id="csvtext" name="csvtext" class="textarea"></textarea>
<br />
<button id="btn_previewcsv" class="button is-link" hx-post="previewcsv.cfm" hx-target="#viewcontainer">PREVIEW CSV</button>
<button id="btn_savecsv" class="button is-warning" hx-post="savecsv.cfm" hx-target="#viewcontainer">SAVE CSV</button>
</form>