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
                    	<?php for($i=0;$i<25;$i++){ ?>
                    	<tr>
                        	<td><input type="text" class="text" name="manguyenlieu[<?php echo $i?>]"></td>
                            <td><input type="text" class="text" name="tennguyenlieu[<?php echo $i?>]"></td>
                            <td>
                            	<select name="loai[<?php echo $i?>]">
                                    <option value=""></option>
                                    <?php foreach($loainguyenlieu as $val){ ?>
                                    <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                                    <?php } ?>
                                </select>
                    		</td>
                            <td>
                            	<select name="makho[<?php echo $i?>]">
                                    <option value=""></option>
                                    <?php foreach($kho as $val){ ?>
                                    <option value="<?php echo $val['makho']?>"><?php echo $val['tenkho']?></option>
                                    <?php } ?>
                                </select>
                            </td>
                            <td>
                            	<select name="madonvi[<?php echo $i?>]">
                                    <option value=""></option>
                                    <?php foreach($donvitinh as $val){ ?>
                                    <option value="<?php echo $val['madonvi']?>"><?php echo $val['tendonvitinh']?></option>
                                    <?php } ?>
                                </select>
                            </td>
                            <td><input type="text" class="text number" name="tontoithieu[<?php echo $i?>]" size="5"></td>
                            <td><input type="text" class="text number" name="tontoida[<?php echo $i?>]" size="5"></td>
                            <td><input type="text" class="text" name="mucdichsudung[<?php echo $i?>]"></td>
                            <td><input type="text" class="text" name="ghichu[<?php echo $i?>]"></td>
                        </tr>
                        <?php } ?>
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

