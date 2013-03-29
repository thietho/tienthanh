<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save(0)"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/linhkien')"/>   
     	        
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<table>
                	<thead>
                        <tr>
                            <th>Mã vạch</th>
                            <th>Mã sản phẩm</th>
                            <th>Tên sản phẩm</th>
                            <th>Kho</th>
                            <th>Đơn vị</th>
                            <th>Trọng lượng</th>
                            <th>Nhóm</th>
                            <th>Loại</th>
                            <th>Số lượng / Lot</th>
                            <?php if($this->user->getUserTypeId()=='admin'){ ?>
                            <th>Đơn giá theo cái</th>
                            <th>Đơn giá theo hộp</th>
                            <th>Đơn giá theo thùng</th>
                            <th>Đơn giá theo lot</th>
                            <?php } ?>
                            <th>Đóng gói</th>
                            <th>Khu vực</th>
                            <th>Phân cấp</th>
                            <th>Hiện hành</th>
                            <th>Ghi chú</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                    	<?php for($i=0;$i<25;$i++){ ?>
                        <form id="frm<?php echo $i?>" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
                    	<tr>
                        	<td><input type="text" class="text" name="mavach"></td>
                            <td><input type="text" class="text" name="masanpham"></td>
                            <td><input type="text" class="text" name="tensanpham"></td>
                            
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
                            <td><input type="text" class="text number" name="trongluong" size="5"></td>
                            <td>
                            	<select id="manhom" name="manhom">
                                    <option value=""></option>
                                    <?php foreach($nhomsanpham as $val){ ?>
                                    <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                                    <?php } ?>
                                </select>
                    		</td>
                            <td>
                            	<select id="loai" name="loai">
                                    <option value=""></option>
                                    <?php foreach($loaisanpham as $val){ ?>
                                    <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                                    <?php } ?>
                                </select>
                            </td>
                            <td><input type="text" class="text number" name="sosanphamtrenlot" size="5"></td>
                            <?php if($this->user->getUserTypeId()=='admin'){ ?>
                            <td><input type="text" class="text number" name="dongiabancai" size="5"></td>
                            <td><input type="text" class="text number" name="dongiabanhop" size="5"></td>
                            <td><input type="text" class="text number" name="dongiabanthung" size="5"></td>
                            <td><input type="text" class="text number" name="dongiabanlot" size="5"></td>
                            <?php } ?>
                            <td><input type="text" class="text number" name="donggoi" size="5"></td>
                            <td><input type="text" class="text number" name="khuvuc" size="5"></td>
                            <td><input type="text" class="text number" name="phancap" size="5"></td>
                            <td><input type="checkbox" name="hienhanh" value="1"></td>
                            <td><input type="text" class="text" name="ghichu"></td>
                            
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
	
	$.post("?route=quanlykho/sanpham/save", $("#frm"+i).serialize(),
		function(data){
			if(data == "true")
			{
				save(i+1);
			}
			else
			{
			
				window.location = "?route=quanlykho/sanpham";
				
			}
			
		}
	);
}



var DIR_UPLOADPHOTO = "<?php echo $DIR_UPLOADPHOTO?>";
</script>

