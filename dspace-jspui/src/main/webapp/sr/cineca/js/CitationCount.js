	var chartType = "Line"; //"Line" or "Bar"
	var maxMinBtn = "max"; //"max" or "min"
	var startYear =  maxYear;
  	var data;
  	var dataAcc;
	var currentData;
	var columnID = [];
  	var columnYEAR = [];
	var options;
	var chart;	
	var rtime = new Date(1, 1, 2000, 12,00,00);
	var timeout = false;
	var delta = 200;

	google.load('visualization', '1', {packages: ['corechart', 'bar']});
	google.setOnLoadCallback(drawChart);

	function chartResizeEnd() {
	    if (new Date() - rtime < delta) {
	        setTimeout(chartResizeEnd, delta);
	    } else {
	        timeout = false;
			redrawCurrentChart();
	    }               
	}
	function chartAddSerie(ID, YEAR, DESCR) {
		JQ("#btnChartAddSerie_"+ID).hide();
		JQ("#btnChartRemoveSerie_"+ID).removeClass("hide");
		JQ("#btnChartRemoveSerie_"+ID).show();
		if (YEAR < startYear) {
			startYear = YEAR;
			if (startYear < minYear) {
				startYear = minYear;
				YEAR = minYear;
			}
		}
		JQ.getJSON( urlScopusRow, {
			compare_product_id: ID,
			format: 'json'
		})
		.success(function( jsonObj ) {
			JQ.each( jsonObj, function( k, item ) {
				var newColumnIndex = data.addColumn('number', JQ('<div/>').html(DESCR).text(), ID);
				var newColumnIndexAcc = dataAcc.addColumn('number', JQ('<div/>').html(DESCR).text(), ID);
				if (newColumnIndex>0) {
					columnID[newColumnIndex] = ID;
					columnYEAR[newColumnIndex] = YEAR;
					var acc = 0;
					for (i = (YEAR - minYear); i < (maxYear - minYear); i++) {
						var current_year = minYear + i;
						data.setValue(i, data.getNumberOfColumns() - 1,  parseInt(eval('item.SCOPUS_CC_' + current_year)));
						acc = acc + parseInt(eval('item.SCOPUS_CC_' + current_year));
						dataAcc.setValue(i, data.getNumberOfColumns() - 1, acc);
					}
				}
			});
			$('#modal-charts .modal-dialog').resizable();
			JQ("#modal-charts").modal('show');
			JQ('body').css('overflow','scroll');
			options.hAxis.viewWindow.min = startYear-minYear;
			options.hAxis.minValue = startYear;
			if (currentData == null) {
				options.title = dataTitle;
				currentData = data;
			}
			redrawCurrentChart();
		})
		.error(function(jqXHR, status, error) {
			console.log(status);
			console.log(error);
			console.error('getJSON fails')
			});
	}
	function chartRemoveSerie(col) {
		data.removeColumn(col);
		var removedID = columnID[col];
		columnID.splice(col, 1);
		columnYEAR.splice(col, 1);
		startYear = maxYear;
		for (i = 0; ((i < columnYEAR.length)); i++) {
			if (columnYEAR[i] < startYear) {
				startYear = columnYEAR[i];
			}
		}
		if (data.getNumberOfColumns() > 1) {
			redrawCurrentChart();
		} else {
			JQ("#modal-charts").modal('hide');
		}
		JQ("#btnChartAddSerie_"+removedID).show();
		JQ("#btnChartRemoveSerie_"+removedID).hide();
	}
	function chartRemoveSerieById(ID) {
		for (i = 0; ((i < columnID.length)); i++) {
			if (ID == columnID[i]) {
				chartRemoveSerie(i);
				return;
			}
		}
	}
	function chartSelect () {
		var sel = chart.getSelection();
		if (sel.length > 0) {
			if (sel[0].row == null) {
				var r = confirm(removeConfirm);
				if (r == true) {
					var col = sel[0].column;
					chartRemoveSerie(col);
				}
			}
		}
	}
	function initData() {
		data = new google.visualization.DataTable();
		data.addColumn('string', labelYear);
		dataAcc = new google.visualization.DataTable();
		dataAcc.addColumn('string', labelYear);
		years = maxYear - minYear;
		for (i = 0; i < years; i++) {
			data.addRows([
			  			['' + (minYear + i)]
			  			]);
			dataAcc.addRows([
			  			['' + (minYear + i)]
			  			]);
		}
	}
	function drawChart() {
		initData();
		options = {
				curveType: 'none',
				legend: {
					position: 'top',
					maxLines: 99,
					},
				hAxis: {
					maxValue: maxYear,
					minValue: startYear,
					viewWindow:{
						min: 0,
						max: maxYear-minYear
					}
				},
				vAxis: {
					format: '0'
					}
			};
		options.width = JQ('#'+chartDivID).width();
		options.height = JQ('#'+chartDivID).height();
        chart = new google.visualization.LineChart(document.getElementById(chartDivID));
		google.visualization.events.addListener(chart, 'select', chartSelect);
	}
	function chartToggle() {
		if (chartType == "Line") {
			chartBar();
		} else {
			chartLine();
		}
	}
	function chartLine() {
		chartType = "Line";
		chart = new google.visualization.LineChart(document.getElementById(chartDivID));
		google.visualization.events.addListener(chart, 'select', chartSelect);
		redrawCurrentChart();
	}
	function chartBar() {
		chartType = "Bar";
		options.orientation = 'horizontal';
		chart = new google.visualization.BarChart(document.getElementById(chartDivID));
		google.visualization.events.addListener(chart, 'select', chartSelect);
		redrawCurrentChart();
	}
	function redrawCurrentChart() {
		//draw chart even if it's not visible...
		options.hAxis.viewWindow.min = startYear-minYear;
		options.hAxis.minValue = startYear;
	    options.width = JQ('#'+chartDivID).width();
		options.height = JQ('#'+chartDivID).height();;
		chart.draw(currentData, options);
	}
    function rawDataGetRows() {
    	var res = "<tbody>";
    	for (var k = 1; k < columnID.length; k++) {
    		res = res + "<tr><td>" + currentData.getColumnLabel(k) + "</td>";
    		for (var i = (startYear - minYear); i < (maxYear - minYear); i++) {
    			var val = currentData.getValue(i, k);
    			if (val==null) val = ' ';
        		res = res + "<td>" + val + "</td>";
        	}
    		res = res + "</tr>";
        }
    	res = res + "</tbody>";
        return res;
    }    
    function rawDataGetColumns() {
    	var res="<thead><tr>";
    	res = res + "<th data-field='name'>" + labelTitle + "</th>";
        for (var i = startYear; i < maxYear; i++) {
        	res = res + "<th data-field='year_" + i + "'><p class='verticalText'>" + i + "</p></th>";
        }
    	res = res + "</tr></thead>";
        return res;
    }
    function startModalDraggable () {
		JQ("#modal-charts").draggable({
			handle: ".modal-header",
			stop: function(){
				var position = JQ( "#modal-charts" ).position();
				if (position.top < 0) {
					JQ( "#modal-charts" ).css('top', '0px' );
				}
				var maxTop = JQ(window).height() - 30;
				if (position.top > maxTop) {
					JQ( "#modal-charts" ).css('top', maxTop+'px' );
				}
			}
		});
		JQ("#modal-charts .modal-header").css("cursor", "move");    	
    }
    function stoptModalDraggable () {
		JQ("#modal-charts").draggable({
			handle: "none",
		});
		JQ("#modal-charts .modal-header").css("cursor", "auto");    	
    }
    function toggleDialogSize () {
		JQ("#modal-charts").css('top', '0px');
		if (maxMinBtn == "max") {
			stoptModalDraggable();
			var chartHeight = JQ(window).height() - JQ("#modal-charts .modal-footer").height() - JQ("#modal-charts .modal-header").height() - JQ(".nav-tabs").height();
			JQ("#modal-charts").css('left', '0px');
			JQ("#modal-charts").width(JQ(window).width()+'px');
			JQ("#modal-charts").height(chartHeight+'px');
			//JQ('#modal-charts').modal('handleUpdate');
			JQ("#modal-charts .modal-dialog").width(JQ(window).width()+'px');
			JQ("#modal-charts .modal-dialog").height(chartHeight+'px');
			JQ("#modal-charts .modal-dialog .modal-content").width(JQ(window).width()+'px');
			JQ("#modal-charts .modal-dialog .modal-content").height(chartHeight+'px');
			JQ("#modal-charts .modal-body").width(JQ(window).width()+'px');
			JQ("#modal-charts .modal-body").height((chartHeight-100)+'px');
			options.width = JQ('#'+chartDivID).width();
			options.height = JQ('#'+chartDivID).height();
			JQ("#maxMinButtonID").html('&searr;');
			JQ("#maxMinButtonID").prop('title', labelMinimize);
			maxMinBtn = "min";
		} else {
			startModalDraggable();
			JQ("#modal-charts").css('left', '50%');
			JQ("#modal-charts").width('600px');
			JQ("#modal-charts").height('500px');
			//JQ('#modal-charts').modal('handleUpdate');
			JQ("#modal-charts .modal-dialog").width('600px');
			JQ("#modal-charts .modal-dialog").height('500px');
			JQ("#modal-charts .modal-dialog .modal-content").width('600px');
			JQ("#modal-charts .modal-dialog .modal-content").height('500px');
			JQ("#modal-charts .modal-body").width('600px');
			JQ("#modal-charts .modal-body").height('400px');
			options.width = JQ('#'+chartDivID).width();
			options.height = JQ('#'+chartDivID).height();;
			JQ("#maxMinButtonID").html('&nwarr;');
			JQ("#maxMinButtonID").prop('title', labelMaximize);
			maxMinBtn = "max"
		}
		redrawCurrentChart();    
    }
    
	JQ(document).ready( function() {
		JQ(document).ajaxComplete(function() {
			for (i = 0; ((i < columnID.length)); i++) {
				JQ("#btnChartAddSerie_"+columnID[i]).hide();
				JQ("#btnChartRemoveSerie_"+columnID[i]).removeClass('hide');
			}
		});
		startModalDraggable();
		JQ("#modal-charts").modal({
			show: false,
			backdrop: false
		});
		JQ('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
			var target = $(e.target).attr("id");
			switch (target) {
			case 'homeLine':
				options.title = dataTitle;
				currentData = data;
				JQ("#chartPrintButtonID").show();
				chartLine();
				break;
			case 'homeBar':
				options.title = dataTitle;
				currentData = data;
				JQ("#chartPrintButtonID").show();
				chartBar();
				break;
			case 'rawDataBtn':
				options.title = dataTitle;
				currentData = data;
				var mytable = "<table class='table table-striped table-bordered table-responsive'>"+rawDataGetColumns() + rawDataGetRows()+"</table>";
				JQ('#'+rawDataTableDivID).html(mytable);				
				JQ("#chartPrintButtonID").hide();
				break;				
			case 'homeLineAcc':
				options.title = dataAccTitle;
				currentData = dataAcc;
				JQ("#chartPrintButtonID").show();
				chartLine();
				break;
			case 'homeBarAcc':
				options.title = dataAccTitle;
				currentData = dataAcc;
				JQ("#chartPrintButtonID").show();
				chartBar();
				break;
			case 'rawDataAccBtn':
				options.title = dataAccTitle;
				currentData = dataAcc;
				var mytable = "<table class='table table-striped table-bordered table-responsive'>"+rawDataGetColumns() + rawDataGetRows()+"</table>";
				JQ('#'+rawDataTableDivID).html(mytable);				
				JQ("#chartPrintButtonID").hide();
				break;				
			}
		});
		
		JQ("#chartPrintButtonID").click(function() {
			  var pwin = window.open(chart.getImageURI(),"_blank");
			  pwin.onload = function () {window.print();}
		});
		JQ("#modal-charts .modal-header").dblclick(function(){
			toggleDialogSize();
		});		
		JQ("#maxMinButtonID").click(function () {
			toggleDialogSize();
		});
		
		JQ("#modal-charts .modal-dialog").on("resize", function(event, ui) {
			JQ("#modal-charts").width(ui.size.width+'px');
			JQ("#modal-charts").height(ui.size.height+'px');
			JQ("#modal-charts .modal-dialog .modal-content").width(ui.size.width+'px');
			JQ("#modal-charts .modal-dialog .modal-content").height(ui.size.height+'px');
			JQ("#modal-charts .modal-body").width(ui.size.width+'px');
			JQ("#modal-charts .modal-body").height((ui.size.height-100)+'px');
		    rtime = new Date();
		    if (timeout === false) {
		        timeout = true;
		        setTimeout(chartResizeEnd, delta);
		    }
		});	

	});
	