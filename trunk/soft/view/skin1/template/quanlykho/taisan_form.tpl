
<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Save" class="button" onClick="save()"/>
     	        <input type="button" value="Cancel" class="button" onclick="linkto('?route=quanlykho/taisan')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Mã tài sản</label><br />
					<input type="text" id="mataisan" name="mataisan" value="<?php echo $item['mataisan']?>" class="text" size=60 <?php echo $readonly?>/>
                    
            	</p>
              	
                
                <p>
            		<label>Tên tài sản</label><br />
					<input type="text" id="tentaisan" name="tentaisan" value="<?php echo $item['tentaisan']?>" class="text" size=60 />
                    
            	</p>
                
               	<p>
            		<label>Số sêri</label><br />
					<input type="text" id="soseri" name="soseri" value="<?php echo $item['soseri']?>" class="text" size=60 />
                    
            	</p>
               	
                <p>
            		<label>Thời hạn bảo hành</label><br />
					<input type="text" id="thoihanbaohanh" name="thoihanbaohanh" value="<?php echo $item['thoihanbaohanh']?>" class="text number" size=60 /> tháng
                    
            	</p>
                
                <p>
            		<label>Nước sản xuất</label><br />
					<input type="text" id="nuocsanxuat" name="nuocsanxuat" value="<?php echo $item['nuocsanxuat']?>" class="text" size=60 />
                    
            	</p>
                
                <p>
            		<label>Năm sản xuất</label><br />
					<input type="text" id="namsanxuat" name="namsanxuat" value="<?php echo $item['namsanxuat']?>" class="text" size=60 />
                    
            	</p>
                <p>
            		<label>Nhóm</label><br />
					<select id="manhom" name="manhom">
                    	<option value=""></option>
                    	<?php foreach($nhomtaisan as $val){ ?>
                        <option value="<?php echo $val['manhom']?>"><?php echo $val['tennhom']?></option>
                        <?php } ?>
                    </select>
            	</p>
                <p>
            		<label>Loại</label><br />
					<select id="loai" name="loai">
                    	<option value=""></option>
                   		<?php foreach($loaitaisan as $val){ ?>
                        <option value="<?php echo $val['manhom']?>"><?php echo $val['tennhom']?></option>
                        <?php } ?>
                    </select>
            	</p>
                <p>
            		<label>Kho</label><br />
					<select id="makho" name="makho">
                    	<option value=""></option>
                    	<?php foreach($kho as $val){ ?>
                        <option value="<?php echo $val['makho']?>"><?php echo $val['tenkho']?></option>
                        <?php } ?>
                    </select>
            	</p>
                <p>
                    <label>Ngày mua</label><br />
<script language="javascript">
$(function() {
    $("#ngaymua").datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd-mm-yy'
            });
    });
</script>
                    <input type="text" id="ngaymua" name="ngaymua" value="<?php echo $this->date->formatMySQLDate($item['ngaymua'])?>" class="text" size=60 />
                </p>
                <p>
            		<label>Khấu hao</label><br />
					<input type="text" id="khauhao" name="khauhao" value="<?php echo $item['khauhao']?>" class="text number" size=60 /> tháng
            	</p>
                <p>
            		<label>Đơn vị tính</label><br />
					<select id="madonvi" name="madonvi">
                    	<option value=""></option>
                    	<?php foreach($donvitinh as $val){ ?>
                        <option value="<?php echo $val['madonvi']?>"><?php echo $val['tendonvitinh']?></option>
                        <?php } ?>
                    </select>
            	</p>
                <p>
            		<label>Đơn giá</label><br />
					<input type="text" id="dongia" name="dongia" value="<?php echo $item['dongia']?>" class="text number" size=60 />
            	</p>
                <p>
            		<label>Mục đích sử dụng</label><br />
					<textarea id="mucdichsudung" name="mucdichsudung"><?php echo $item['mucdichsudung']?></textarea>
            	</p>
                <p>
            		<label>Ghi chú</label><br />
					<textarea id="ghichu" name="ghichu"><?php echo $item['ghichu']?></textarea>
            	</p>
               	<p id="pnImage">
                    <label for="image">Hình</label><br />
                    <a id="btnAddImage" class="button">Chọn hình</a><br />
                    <img id="preview" src="<?php echo $item['imagethumbnail']?>" />
                    <input type="hidden" id="imagepath" name="imagepath" value="<?php echo $item['imagepath']?>" />
                    <input type="hidden" id="imageid" name="imageid" value="<?php echo $item['imageid']?>" />
                    <input type="hidden" id="imagethumbnail" name="imagethumbnail" value="<?php echo $item['imagethumbnail']?>" />
                </p>
                
                
                <div id="errorupload" class="error" style="display:none"></div>
                
                <div class="loadingimage" style="display:none"></div>
               
               
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/taisan/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/taisan";
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