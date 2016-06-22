<!DOCTYPE html>

<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="icon" href="../../favicon.ico">

  <title>Starter Template for Bootstrap</title>

  <!-- Bootstrap core CSS -->
  <link href="/beacon/css/bootstrap.min.css" rel="stylesheet">
  <link href="/beacon/css/bootstrap-theme.min.css" rel="stylesheet">

  <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<#--<link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">-->

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

  <!-- Custom CSS -->
  <link rel="stylesheet" href="/beacon/css/datatables.css"/>

  <style type="text/css">

    label {
      font-weight: 700;
    }

    .dropdown-menu > li > a {
      cursor: pointer;
    }

    .sidebar {
      position: fixed;
      top: 51px;
      bottom: 0;
      left: 0;
      z-index: 1000;
      display: block;
      padding: 20px;
      overflow-x: hidden;
      overflow-y: auto;
      background-color: #f5f5f5;
      border-right: 1px solid #eee;
    }

    .starter-template {
      padding: 20px 15px;
      text-align: center;
    }

    body {
      padding-top: 40px;
    }

    .public_link {
      font-style: italic;
    }

    #uploader {
      display: block;
      text-align: right;
      height: auto;
      min-height: 30px;
      overflow: hidden;
    }

    #loading-wrap {
      position: fixed;
      height: 100%;
      width: 100%;
      overflow: hidden;
      top: 0;
      left: 0;
      display: block;
      background: white url('/beacon/themes/canfar/images/ajax-loader.gif') no-repeat center center;
      z-index: 999;
      opacity: 0.7;
    }

    main.container {
      background: transparent !important;
    }

    .container {
      width: auto !important;
    }
  </style>
</head>

<body>

<#if username??>
  <#assign homeURL = '/beacon/list/${username}'>
</#if>

<#include "_top_nav.ftl">

<div class="container-fluid">

<#include "_main.ftl">

</div><!-- /.container -->


<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="/beacon/js/jquery.min.js"></script>
<script src="/beacon/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<#--<script src="/beacon/js/ie10-viewport-bug-workaround.js"></script>-->

<script type="text/javascript" src="/beacon/js/cadc.util.js"></script>
<script type="text/javascript" src="/beacon/js/cadc.uri.js"></script>
<script type="text/javascript" src="/beacon/js/datatables.js"></script>
<script type="text/javascript" src="/beacon/js/file-size.js"></script>
<script type="text/javascript" src="/beacon/js/jquery.csv-0.71.min.js"></script>
<script type="text/javascript" src="/beacon/js/jquery-browser.js"></script>
<script type="text/javascript" src="/beacon/js/jquery.form-3.24.js"></script>
<script type="text/javascript"
        src="/beacon/js/jquery.contextmenu/jquery.contextMenu-1.01.js"></script>
<script type="text/javascript"
        src="/beacon/js/jquery.tablesorter-2.7.2.min.js"></script>
<script type="text/javascript"
        src="/beacon/js/jquery.impromptu-3.2.min.js"></script>
<script type="text/javascript" src="/beacon/js/filemanager.js"></script>

<script type="text/javascript">

  var lockedIcon =
      "<span class=\"glyphicon glyphicon-lock\"></span> <a href=\"/beacon/unlock\" title=\"Unlock to modify.\">Unlock</a>";
  var publicLink =
      "<a href=\"#\" class=\"public_link\" title=\"Change group read access.\">Public</a>";
  var stringUtil = new cadc.web.util.StringUtil(publicLink);
  var startURI = "<#if startURI??>${startURI}</#if>";
  var url = "/beacon/page${folder.path}";
  var defaultPageSize = 400;

  var requestData = {};

  requestData.pageSize = defaultPageSize;

  if (startURI != "")
  {
    requestData.startURI = encodeURIComponent(startURI);
  }

  $(document).ready(function ()
                    {
                      // Override CSS for search filter field.
                      $.fn.DataTable.ext.oStdClasses.sFilter =
                          "dataTables_filter mrgn-lft-md mrgn-tp-md";
                      var $beaconTable = $("#beacon");

                      var $dt = $beaconTable.DataTable({
                                                         language: {
                                                           search: "_INPUT_",
                                                           searchPlaceholder: "Search Name..."
                                                         },
                                                         loading: true,
                                                         processing: true,
                                                         deferRender: true,
                                                         scrollY: "615px",
                                                         lengthChange: false,
                                                         scrollCollapse: true,
                                                         scroller: true,
                                                         columnDefs: [
                                                           {
                                                             "targets": 0,
                                                             "orderable": false,
                                                             "className": 'select-checkbox',
                                                             "searchable": false,
                                                             "render": function (data, type, full, meta)
                                                             {
                                                               var renderedValue;

                                                               if (full.length >
                                                                   6)
                                                               {
                                                                 var lockedFlag =
                                                                     (full[7] ===
                                                                      "true");

                                                                 renderedValue =
                                                                     lockedFlag ?
                                                                     lockedIcon :
                                                                     data;
                                                               }
                                                               else
                                                               {
                                                                 renderedValue =
                                                                     data;
                                                               }

                                                               return renderedValue;
                                                             }
                                                           },
                                                           {
                                                             "targets": 1,
                                                             "render": function (data, type, full, meta)
                                                             {
                                                               if (full.length >
                                                                   9)
                                                               {
                                                                 var isDirectory =
                                                                     (full[8] ==
                                                                      'ContainerNode');
                                                                 var path = (isDirectory ?
                                                                             "list" :
                                                                             "download")
                                                                            +
                                                                            full[9];
                                                                 return '<span class="glyphicon '
                                                                        +
                                                                        (isDirectory
                                                                            ?
                                                                         'glyphicon-folder-open'
                                                                            :
                                                                         'glyphicon-cloud-download')
                                                                        +
                                                                        '"></span> <a href="/beacon/'
                                                                        + path +
                                                                        '" title=""> '
                                                                        + data +
                                                                        '</a>';
                                                               }
                                                               else
                                                               {
                                                                 return data;
                                                               }
                                                             }
                                                           },
                                                           {
                                                             "type": "file-size",
                                                             "targets": 2
                                                           },
                                                           {
                                                             "targets": 4,
                                                             "searchable": false,
                                                             "render": function (data, type, full, meta)
                                                             {
                                                               var renderedValue;

                                                               if (full.length >
                                                                   9)
                                                               {
                                                                 var publicFlag =
                                                                     (full[6] ===
                                                                      "true");
                                                                 var path = full[9];

                                                                 if (publicFlag ===
                                                                     true)
                                                                 {
                                                                   renderedValue =
                                                                       stringUtil.format(path);
                                                                 }
                                                                 else
                                                                 {
                                                                   renderedValue =
                                                                       data;
                                                                 }
                                                               }
                                                               else
                                                               {
                                                                 renderedValue =
                                                                     data;
                                                               }

                                                               return renderedValue;
                                                             }
                                                           },
                                                           {
                                                             "targets": [2, 3,
                                                                         5],
                                                             "searchable": false
                                                           }
                                                         ],
                                                         select: {
                                                           style: 'os',
                                                           selector: 'td:first-child'
                                                         },
                                                         order: [[5, 'desc']]
                                                       });

                      var successCallback = function (csvData)
                      {
                        var data = $.csv.toArrays(csvData);

                        if (data.length > 0)
                        {
                          for (var di = 0, dl = data.length; di < dl; di++)
                          {
                            var nextRow = data[di];
                            $dt.row.add(nextRow);

                            startURI = nextRow[10];
                          }

                          $dt.draw();

                          requestData.startURI = startURI;
                          getPage(requestData, successCallback);
                        }
                      };

                      load(successCallback);
                    });

  function load(_callback)
  {
    getPage(requestData, _callback);
  }

  function getPage(_data, _callback)
  {
    $.get({
            url: url,
            dataType: "text",
            data: _data
          })
        .done(function (csvData)
              {
                _callback(csvData);
              });
  }
</script>
</body>
</html>

