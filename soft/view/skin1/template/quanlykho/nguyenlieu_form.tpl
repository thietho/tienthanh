<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/nguyenlieu#page='+control.getParam('page'))"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Mã nguyên vật liệu</label><br />
					<input type="text" id="manguyenlieu" name="manguyenlieu" value="<?php echo $item['manguyenlieu']?>" class="text" size=60 <?php echo $readonly?>/>
                    
            	</p>
              	
                
                <p>
            		<label>Tên nguyên vật liệu</label><br />
					<input type="text" id="tennguyenlieu" name="tennguyenlieu" value="<?php echo $item['tennguyenlieu']?>" class="text" size=60 />
                    
            	</p>
              
                <p>
            		<label>Loại</label><br />
					<select id="loai" name="loai">
                    	
                   		<?php foreach($loainguyenlieu as $val){ ?>
                        <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level'])?><?php echo $val['tennhom']?></option>
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
            		<label>Tồn tối thiểu</label><br />
					<input type="text" id="tontoithieu" name="tontoithieu" value="<?php echo $item['tontoithieu']?>" class="text number" size=60 />
            	</p>
                <p>
            		<label>Tồn tối đa</label><br />
					<input type="text" id="tontoida" name="tontoida" value="<?php echo $item['tontoida']?>" class="text number" size=60 />
            	</p>
                <p>
            		<label>Số lượng 1 lần đăt hàng</label><br />
					<input type="text" id="soluongmoilandathang" name="soluongmoilandathang" value="<?php echo $item['soluongmoilandathang']?>" class="text number" size=60 />
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
	
	$.post("?route=quanlykho/nguyenlieu/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/nguyenlieu#page="+control.getParam('page');
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
