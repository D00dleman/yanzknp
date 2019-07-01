<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8">
	<title>Process-port controller</title>
</head>
<body>
	%for i in ports:
	<p>
	%	for o in lsofs[i]:
		{{o}}<br>
	%	end
	</p><br>
	<a href="killall/{{i}}">Перезагрузить порт {{i}}</a>
	<hr>
	%end
</body>
</html>