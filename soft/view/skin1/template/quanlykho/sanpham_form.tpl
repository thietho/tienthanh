<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form id="frm_sanpham_form" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Mã vạch</label><br />
					<input type="text" id="mavach" name="mavach" value="<?php echo $item['mavach']?>" class="text" size=60 />
                    
            	</p>
              	
                <p>
            		<label>Mã sản phẩm</label><br />
					<input type="text" id="masanpham" name="masanpham" value="<?php echo $item['masanpham']?>" class="text" size=60 />
                    
            	</p>
                
                <p>
            		<label>Tên sản phẩm</label><br />
					<input type="text" id="tensanpham" name="tensanpham" value="<?php echo $item['tensanpham']?>" class="text" size=60 />
                    
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
            		<label>Trọng lượng</label><br />
					<input type="text" id="trongluong" name="trongluong" value="<?php echo $item['trongluong']?>" class="text number" size=60 /> Kg
            	</p>
                <p>
            		<label>Nhom</label><br />
					<select id="manhom" name="manhom">
                    	<option value=""></option>
                   		<?php foreach($nhomsanpham as $val){ ?>
                        <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                        <?php } ?>
                    </select>
            	</p>
                
                <p>
            		<label>Loại</label><br />
					<select id="loai" name="loai">
                    	<option value=""></option>
                   		<?php foreach($loaisanpham as $val){ ?>
                        <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
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
            		<label>Số sản phẩm/Lot</label><br />
					<input type="text" id="sosanphamtrenlot" name="sosanphamtrenlot" value="<?php echo $item['sosanphamtrenlot']?>" class="text number" size=60 />
            	</p>
                <?php if($this->user->getUserTypeId()=='admin'){ ?>
                <p>
            		<label>Giá cố định</label><br />
					<input type="text" id="giacodinh" name="giacodinh" value="<?php echo $item['giacodinh']?>" class="text number" size=60 />
            	</p>
                <p>
            		<label>Đơn giá bán theo cái</label><br />
					<input type="text" id="dongiabancai" name="dongiabancai" value="<?php echo $item['dongiabancai']?>" class="text number" size=60 />
            	</p>
                <p>
            		<label>Đơn giá bán theo hộp</label><br />
					<input type="text" id="dongiabanhop" name="dongiabanhop" value="<?php echo $item['dongiabanhop']?>" class="text number" size=60 />
            	</p>
                <p>
            		<label>Đơn giá bán theo thùng</label><br />
					<input type="text" id="dongiabanthung" name="dongiabanthung" value="<?php echo $item['dongiabanthung']?>" class="text number" size=60 />
            	</p>
                <p>
            		<label>Đơn giá bán theo lot</label><br />
					<input type="text" id="dongiabanlot" name="dongiabanlot" value="<?php echo $item['dongiabanlot']?>" class="text number" size=60 />
            	</p>
                <?php } ?>
                <p>
            		<label>Đóng gói</label><br />
					<input type="text" id="donggoi" name="donggoi" value="<?php echo $item['donggoi']?>" class="text number" size=60 />
            	</p>
                <p>
            		<label>Khu vực</label><br />
					<input type="text" id="khuvuc" name="khuvuc" value="<?php echo $item['khuvuc']?>" class="text number" size=60 />
            	</p>
                
                <p>
            		<label>Phân cấp</label><br />
					<input type="text" id="phancap" name="phancap" value="<?php echo $item['phancap']?>" class="text number" size=60 />
            	</p>
                <p>
            		<label>Hiện hành</label><br />
					<input type="checkbox" id="hienhanh" name="hienhanh" value="1">
            	</p>
                <p>
            		<label>Ghi chú</label><br />
					<textarea id="ghichu" name="ghichu"><?php echo $item['ghichu']?></textarea>
            	</p>
               	<p id="pnImage">
                    <label for="image">Hình</label><br />
                    
                    <input type="button" class="button" value="Chọn hình" onclick="browserFile('imageid','single')"/><br />
                    <img id="imageid_preview" src="<?php echo $item['imagethumbnail']?>" onclick="showFile($('#imageid_fileid').val())"/>
                    <input type="hidden" id="imageid_filepath" name="imagepath" value="<?php echo $item['imagepath']?>" />
                    <input type="hidden" id="imageid_fileid" name="imageid" value="<?php echo $item['imageid']?>" />
                </p>
                
                
                <div id="errorupload" class="error" style="display:none"></div>
                
                <div class="loadingimage" style="display:none"></div>
               
               
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">


$("#frm_sanpham_form #manhom").val("<?php echo $item['manhom']?>");
$("#frm_sanpham_form #loai").val("<?php echo $item['loai']?>");
$("#frm_sanpham_form #makho").val("<?php echo $item['makho']?>");
$("#frm_sanpham_form #madonvi").val("<?php echo $item['madonvi']?>");
var DIR_UPLOADPHOTO = "<?php echo $DIR_UPLOADPHOTO?>";
</script>
