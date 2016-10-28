<div class="row">
  <div role="navigation" class="col-sm-3 col-md-2 sidebar">
    <ul class="nav nav-sidebar">
      <li><a href="http://www.canfar.phys.uvic.ca/canfar/groups">&nbsp;Manage Groups</a></li>
      <li><a href="#" title="Space allocations.">&nbsp;Manage Allocations</a></li>
    </ul>

    <ul class="nav nav-sidebar">
      <li><a href="http://www.canfar.net/docs/vospace/">&nbsp;Web Service Documentation</a></li>
    </ul>

    <ul class="nav nav-sidebar">
      <li><a class="github-link social-link" href="http://www.github.com/opencadc/vosui"><span>GitHub</span></a></li>
      <li><a class="docker-link social-link" href="https://hub.docker.com/r/canfar/storage/"><span>Docker</span></a></li>
    </ul>

    <form id="uploader" method="post" class="hidden">
      <h1 title="${folder.path}" class="hidden">${folder.path}</h1>
      <div id="uploadresponse"></div>
      <input id="mode" name="mode" type="hidden" value="add" />
      <input id="currentpath" name="currentpath" type="hidden" value="${folder.path}"/>
      <div id="file-input-container" class="wb-inv">
        <div id="alt-fileinput">
          <input id="filepath" name="filepath" type="text" title="File path." />
          <button id="browse" name="browse" type="button" class="btn" value="Browse"></button>
        </div>
        <input id="newfile" name="newfile" type="file" webkitdirectory="" directory="" mozdirectory="" />
      </div>
      <button id="upload" name="upload" type="submit" value="Upload" class="em">
        <span class="glyphicon glyphicon-cloud-upload"></span>&nbsp;Upload</button>
      <input id="currentpath" name="currentpath" type="hidden" value="${folder.path}"/>
    </form>
  </div>

  <!-- Main content -->
  <div role="main" class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
    <h1 class="hidden" property="name">${folder.path}</h1>
    <section>
      <h2 property="name">
      <#if isRoot>
        ROOT
      <#else>
        <button id="more_details" name="more_details" class="btn btn-info btn-xs"
                data-placement="bottom" data-toggle="popover"
                role="button">
          <span class="glyphicon glyphicon-eye-open"></span>&nbsp;<span class="caret"></span></button>
        ${folder.path}
      </#if>
      </h2>
    </section>

    <#flush>

    <section>
      <div id="fileinfo" class="table-responsive">
        <nav class="navbar navbar-default">
          <div class="container-fluid">
            <div class="collapse navbar-collapse" id="navbar-functions">
              <ul class="nav navbar-nav">
<#if !isRoot>
                <li>
                  <a id="level-up" name="level-up" href="/storage/app/list${folder.parentPath}" role="button" title="Up one level">
                    <span class="glyphicon glyphicon-level-up"></span>&nbsp;Up</a></li>
                <li>
                  <a id="root" name="root" type="button" title="Navigate to main root." href="/storage/app/list/">
                    <span class="glyphicon glyphicon-home"></span>&nbsp;Root</a></li>
                <li class="dropdown divider-vertical <#if !folder.writable>disabled</#if>">
                  <a title="New" class="dropdown-toggle <#if !folder.writable>disabled</#if>" role="button" id="newdropdown" name="newdropdown" aria-expanded="false" data-toggle="dropdown">
                    <span class="glyphicon glyphicon-plus"></span>&nbsp;New&nbsp;<span class="caret"></span></a>
                  <ul class="dropdown-menu">
                    <li>
                      <a id="newfolder">
                        <span class="glyphicon glyphicon-folder-open"></span>&nbsp;Folder</a></li>
                    <li>
                      <a id="upload">
                        <span class="glyphicon glyphicon-cloud-upload"></span>&nbsp;File</a>
                      <form id="uploader" method="post" class="hidden">
                        <input id="currentpath" name="currentpath" type="hidden" value="${folder.path}"/>
                      </form>
                    </li>
                    <li class="disabled">
                      <a id="new_vospace_link" class="disabled"><span class="glyphicon glyphicon-link"></span>&nbsp;VOSpace Link</a></li>
                    <li>
                      <a id="new_external_link"><span class="glyphicon glyphicon-link"></span>&nbsp;External Link</a></li>
                  </ul>
                </li>
                <li class="disabled dropdown divider-vertical multi-select-function-container">
                  <a disabled="disabled" class="disabled dropdown-toggle multi-select-function" id="download" role="button" name="download" type="button" aria-expanded="false" data-toggle="dropdown" title="Download selected items.">
                    <span class="glyphicon glyphicon-cloud-download"></span>&nbsp;Download&nbsp;<span class="caret"></span></a>
                  <ul class="dropdown-menu download-dropdown-menu">
                    <li><a class="download-url-list"><span class="glyphicon glyphicon-list"></span>&nbsp;URL List</a></li>
                    <li><a class="download-zip-file"><span class="glyphicon glyphicon-compressed"></span>&nbsp;ZIP</a></li>
                    <li><a class="download-download-manager"><span class="glyphicon glyphicon-download-alt"></span>&nbsp;Download Manager</a></li>
                  </ul>
                </li>
</#if>
                <li class="dataTables_filter">
                  <form class="navbar-form navbar-left" role="search">
                    <input id="beacon_filter" class="form-control dataTables_filter"
                           aria-controls="beacon" placeholder="Search Name..." type="search" />
                  </form>
                </li>
<#if !isRoot>
                <#-- Disabled by default -->
                <li class="disabled multi-select-function-container">
                  <a disabled="disabled" class="disabled multi-select-function" id="delete" name="delete" role="button" title="Delete selected items">
                    <span class="glyphicon glyphicon-trash"></span>&nbsp;Delete</a></li>
</#if>
              </ul>
            </div>
          </div>
        </nav>
        <!-- The width style here MUST exist in this tag, rather than in the CSS file. -->
        <table id="beacon" class="table table-striped table-condensed table-hover" style="width: 100%;">
          <thead>
            <tr>
              <th></th>
              <th>Name</th>
              <th>Size</th>
              <th>Last Modified (UTC)</th>
              <th>Read/Write</th>
              <th>Read</th>
            </tr>
          </thead>
          <tbody>
          </tbody>
        </table>
      </div>
    </section>
  </div>
</div>

