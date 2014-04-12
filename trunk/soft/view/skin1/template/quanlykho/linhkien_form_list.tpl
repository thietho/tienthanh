<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save(0)"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/linhkien#page='+control.getParam('page',strurl))"/>   
     	        
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<table>
                	<thead>
                        <tr>
                            <th>Mã linh kiện</th>
                            <th>Tên linh kiện</th>
                            <th>Kho</th>
                            <th>Đơn vị</th>
                            <th>Linh kiện/Lot</th>
                            <th>Số lượng con/Kg</th>
                            <th>Tiên công</th>
                            <th>Định mức</th>
                            <th>Ghi chú</th>
                            <th>Nguyên liệu sử dụng</th>
                            <th>Số lượng</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<?php for($i=0;$i<25;$i++){ ?>
                        <form id="frm<?php echo $i?>" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
                    	<tr>
                        	<td><input type="text" class="text" name="malinhkien"></td>
                            <td><input type="text" class="text" name="tenlinhkien"></td>
                            
                            <td>
                            	<select name="makho">
                                    <option value=""></option>
                                    <?php foreach($kho as $val){ ?>
                                    <option value="<?php echo $val['makho']?>"><?php echo $val['tenkho']?></option>
                                    <?php } ?>
                                </select>
                            </td>
                            <td>
                            	<select name="madonvi">
                                    <option value=""></option>
                                    <?php foreach($donvitinh as $val){ ?>
                                    <option value="<?php echo $val['madonvi']?>"><?php echo $val['tendonvitinh']?></option>
                                    <?php } ?>
                                </select>
                            </td>
                            <td><input type="text" class="text number" name="solinhkientrenlot" size="5"></td>
                            <td><input type="text" class="text number" name="soluongcontrenkg" size="5"></td>
                            <td><input type="text" class="text number" name="tiencong" size="5"></td>
                            <td><input type="text" class="text number" name="dinhmuc" size="5"></td>
                            <td><input type="text" class="text" name="ghichu"></td>
                            <td>
                            	<select name="nguyenlieusudung">
                                    <option value=""></option>
                                    <?php foreach($data_nguyenlieu as $val){ ?>
                                    <option value="<?php echo $val['id']?>"><?php echo $val['tennguyenlieu']?></option>
                                    <?php } ?>
                                </select>
                            </td>
                            <td><input type="text" class="text number" name="soluongnguyenlieu" size="5"></td>
                        </tr>
                        </form>
                        <?php } ?>
                    </tbody>
                </table>
               
            </div>
            
        
    
    </div>
    
</div>
<script language="javascript">
function save(i)
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/linhkien/save", $("#frm"+i).serialize(),
		function(data){
			if(data == "true")
			{
				//window.location = "?route=quanlykho/nguyenlieu";
				save(i+1);
			}
			else
			{
			
				window.location = "?route=quanlykho/linhkien";
				
			}
			
		}
	);
}



var DIR_UPLOADPHOTO = "<?php echo $DIR_UPLOADPHOTO?>";
</script>

