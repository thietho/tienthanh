<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $heading_title?>Nguyên liệu</div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/nguyenlieu')"/>   
     	        
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<table>
                	<thead>
                        <tr>
                            <th>Mã nguyên liệu</th>
                            <th>Tên nguyên liệu</th>
                            <th>Loại</th>
                            <th>Kho</th>
                            <th>Đơn vị</th>
                            <th>Tồn tối thiểu</th>
                            <th>Tồn tối đa</th>
                            <th>Mục đích sử dụng</th>
                            <th>Ghi chú</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<tr>
                        	<td><input type="text" class="text"></td>
                            <td><input type="text" class="text"></td>
                            <td>
                            	<select id="loai" name="loai">
                                    <option value=""></option>
                                    <?php foreach($loainguyenlieu as $val){ ?>
                                    <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                                    <?php } ?>
                                </select>
                    		</td>
                            <td>
                            	<select id="makho" name="makho">
                                    <option value=""></option>
                                    <?php foreach($kho as $val){ ?>
                                    <option value="<?php echo $val['makho']?>"><?php echo $val['tenkho']?></option>
                                    <?php } ?>
                                </select>
                            </td>
                            <td>
                            	<select id="madonvi" name="madonvi">
                                    <option value=""></option>
                                    <?php foreach($donvitinh as $val){ ?>
                                    <option value="<?php echo $val['madonvi']?>"><?php echo $val['tendonvitinh']?></option>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                    </tbody>
                </table>
               
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/nguyenlieu/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/nguyenlieu";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}

$("#manhom").val("<?php echo $item['manhom']?>");
$("#loai").val("<?php echo $item['loai']?>");
$("#makho").val("<?php echo $item['makho']?>");
$("#madonvi").val("<?php echo $item['madonvi']?>");

var DIR_UPLOADPHOTO = "<?php echo $DIR_UPLOADPHOTO?>";
</script>
<script src='<?php echo DIR_JS?>ajaxupload.js' type='text/javascript' language='javascript'> </script>
<script src="<?php echo DIR_JS?>uploadpreview.js" type="text/javascript"></script>
