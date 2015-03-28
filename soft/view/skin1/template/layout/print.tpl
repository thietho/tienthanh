<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta name="author" content="" />

</head>
<style>
body
{
	font-family:Tahoma, Geneva, sans-serif;	
	font: normal 72% sans-serif;
}
h1,h2,h3,h4,h5,h6 
{
	margin:2px 0;
	text-transform:uppercase
}
p
{
	margin:0;	
	font-size:0.8em;
}
table
{
	width:100%;	
	border-collapse: collapse;
	border-spacing: 0;
}
.cusinfo
{
	font-size:0.9em;	
}
.number {
	text-align: right;
}
.text-left {text-align: left;}
.text-right {text-align: right;}
.text-center {text-align: center;}
.text-separator {padding: 0 5px;}
.table-data td
{
	border-top:thin dashed #666;
	border-left:thin solid #000;
}
.table-data th
{
	border:thin solid #000;
	
}

.table-data
{
	border-right:thin solid #000;
	border-bottom:thin solid #000;
}
label
{
	font-weight:bold;
	text-transform:uppercase;
}
</style>

<body>

<div id="site-wrapper">

<div class="main">
<center>
	<?php echo html_entity_decode($this->document->setup['HeaderBill'])?>
</center>
<div id="main-content"><?php echo $content?></div>

<div class="clearer">&nbsp;</div>


</div>



</div>

</body>

</html>
<script>
window.print();
</script>