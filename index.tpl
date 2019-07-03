<!DOCTYPE HTML>
<html>
%colors = {
%'headBack': "#2B7485",
%'headText': "	#A8EFFF",
%'background': "#A8EFFF",
%'blockBack': "#EEFCFF",
%'tableBack': "#2B7485",
%'buttonBack': "#2C3E42"}
<head>
	<meta charset="utf-8">
	<title>Pid-Port Controller</title>
	<style>
		table {
			text-align: center;
			padding-top: 1%;
			padding-left: 1%;
		}
		header {
			background: {{colors["headBack"]}};
			color: {{colors["headText"]}};
			padding-left: 1%;
			padding-right: 1%;
			font-size: x-large;
			box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.14), 0 1px 5px 0 rgba(0, 0, 0, 0.12), 0 3px 1px -2px rgba(0, 0, 0, 0.2);
			font-weight: lighter;
			line-height: 2;
		}
		body {
			background: {{colors["background"]}};
			margin-top: 0px;
			margin-right: 0px;
			margin-left: 0px;
			margin-bottom: 0px;
			font-family: Open Sans,sans-serif;
		}
		table {
		}
		a {
			text-decoration: none;
		}
		.killButton {
			background-color: {{colors["buttonBack"]}};
			border-radius: 5px;
			color: {{colors["background"]}};
			border: 0px;
			font-weight: 100;
			font-family: Open Sans,sans-serif;
			font-size: 120%;
			margin-top: 1%;
			margin-left: 1%;
			margin-bottom: 1%;
		}
		.killButton:hover {
			background-color: {{colors["tableBack"]}};
		}
		#portInfo {
			box-shadow: 0 1px 2px rgba(0,0,0,.2);
			background-color: {{colors["blockBack"]}};
			margin-top: 1%;
			margin-bottom: 1%;
			margin-left: 1%;
			margin-right: 1%;
			overflow: auto;
		}
		td {
			background: {{colors["tableBack"]}};
			color: {{colors["blockBack"]}};
			border-radius: 2px;
		}
	</style>
</head>
<body>
	<header>
		Pid-Port Controller
	</header>
	%for i in ports:
	%	dd = lsofs[i]
		<div id="portInfo">
	%	if(dd != ['']):
			<table><tbody>
			<tr>
			<td>Process</td>
			<td>PID</td>
			<td>Status</td>
			</tr>
	%		for o in dd[1:]:
				<tr>
	%			p = o.split()
				<td>{{p[0]}}</td>
				<td>{{p[1]}}</td>
				<td>{{p[9].replace("(","").replace(")","")}}</td>
				</tr>
	%		end
			</table></tbody>
	%	end
		<a href="killall/{{i}}"><input type="button" class="killButton" value="Kill port {{i}}"></a>
		</div>
	%end
</body>
</html>