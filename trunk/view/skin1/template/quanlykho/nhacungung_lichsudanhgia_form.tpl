<script src='<?php echo DIR_JS?>ui.datepicker.js' type='text/javascript' language='javascript'> </script>
<div class="section" id="sitemaplist">

	<div class="section-title">Đánh giá nhà cung ứng</div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Save" class="button" onClick="save()"/>
     	        <input type="button" value="Cancel" class="button" onclick="linkto('?route=quanlykho/nhacungung/lichsudanhgia&id=<?php echo $item['id']?>')"/>   
     	        <input type="hidden" name="manhacungung" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="container">
                <div id="fragment-danhgia">
                	<p>
                    	<label>Mã nhà cung ứng</label><br>
                        <?php echo $item['manhacungung']?>
                    </p>
                    <p>
                    	<label>Tên nhà cung ứng</label><br>
                        <?php echo $item['tennhacungung']?>
                    </p>
                	<p>
                        <label>Ngày đánh giá lại</label><br />
<script language="javascript">
 	$(function() {
		$("#ngaydanhgialai").datepicker({
				changeMonth: true,
				changeYear: true,
				dateFormat: 'dd-mm-yy'
				});
		});
 </script>
                        <input type="text" id="ngaydanhgia" name="ngaydanhgia" value="<?php echo $this->date->formatMySQLDate($this->date->getToday())?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Về số lượng</label><br />
                        
                        <select id="danhgiasoluong" name="danhgiasoluong">
                        	<option value=""></option>
                        	<?php foreach($this->document->danhgia as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <p>
                        <label>Về chất lượng</label><br />
                        
                        <select id="danhgiachatluong" name="danhgiachatluong">
                        	<option value=""></option>
                        	<?php foreach($this->document->danhgia as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <p>
                        <label>Về thời gian cung ứng</label><br />
                        
                        <select id="danhgiathoigian" name="danhgiathoigian">
                        	<option value=""></option>
                        	<?php foreach($this->document->danhgia as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <p>
                        <label>Về thanh toán</label><br />
                        
                        <select id="danhgiathanhtoan" name="danhgiathanhtoan">
                        	<option value=""></option>
                        	<?php foreach($this->document->danhgia as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val?></option>
                            <?php } ?>
                        </select>
                    </p>
                </div>
            </div>
                
            
        </form>
    
    </div>
    
</div>
<script src="<?php echo DIR_JS?>jquery.tabs.pack.js" type="text/javascript"></script>
<script language="javascript">

function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/nhacungung/savedanhgia", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/nhacungung/lichsudanhgia&id=<?php echo $item['id']?>";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}



</script>
