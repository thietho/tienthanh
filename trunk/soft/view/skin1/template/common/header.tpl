<script type="text/javascript">
<!--
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='index.php?lang="+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
//-->
</script>
<div id="top">

<div class="left text-center" id="weblogo"><a href="index.html"> <img
	class="png" src="<?php echo DIR_IMAGE?>ben_logo.gif" alt="" /><br />
</a></div>

<div class="left"><?php if($sitename) {?>
<p>Content Management System</p>
<h2><?php echo $sitename?></h2>
<?php } else { ?>
<h2>Content Management System</h2>
<?php } ?>

<div class="clearer">&nbsp;</div>

</div>

<div class="right text-center" id="logo"><a href="index.html"> 
	<img class="png" src="<?php echo DIR_IMAGE?>ben_logo.gif" alt="" /><br />
</a></div>

<div class="right">
	<table>
    	<tr>
        	<td><a href="?route=page/home"><img class="png" src="<?php echo DIR_IMAGE?>home.png" alt="" /></a></td>
            <td>
            	
                <ul class="nicelist">
                	
                    <li><a href="index.php?route=common/profile">Logged user: <b><?php echo $username?></b></a></li>
                    <li><a href="index.php?route=common/changepassword"><?php echo $button_change_password?></a></li>
                    <li><a href="logout.php"><?php echo $button_logout?></a></li>
                </ul>
            </td>
        </tr>
    </table>
	
	

</div>

<div class="clearer">&nbsp;</div>

</div>
