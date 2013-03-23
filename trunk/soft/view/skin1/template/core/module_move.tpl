<div class="section" id="sitemaplist">

	
    
    <div class="section-content padding1">
    
    	<form name="frmkhuvuc" id="frmkhuvuc" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<a class="button save" onclick="khuvuc.updateParent($('#khuvucid').val(),$('#khuvuccha').val())">Lưu</a>
     	        
     	        <input type="hidden" id="khuvucid" name="khuvucid" value="<?php echo $item['khuvucid']?>">
                
                
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>   
            	
                
                
                <p>
                    <label>Tên khu vực:</label><br />
                    <?php echo $item['tenkhuvuc']?>
                </p>               
                <p>
                    <label>Loại khu vực:</label><br />
                    <?php echo $this->document->loaikhuvuc[$item['loaikhuvuc']]?>
                </p>
                <p>
                    <label>Chọn khu vực cha:</label><br />
                    <select id="khuvuccha" name="khuvuccha">
                        <option value="">Khu vực gốc</option>
                        <?php foreach($khuvucs as $khuvuc){ ?>
                        <option value="<?php echo $khuvuc['khuvucid']?>"><?php echo $this->string->getPrefix("&nbsp; &nbsp; &nbsp; &nbsp;",$khuvuc['level']);?><?php echo $khuvuc['tenkhuvuc']?></option>
                      <?php }?>
                    </select>
                </p>
            </div>
            
        </form>
    
    </div>
    
</div>
