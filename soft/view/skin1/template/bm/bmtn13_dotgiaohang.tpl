	<label>Đợt giao hàng</label>
    <ul>
    	<?php foreach($data_dotgiaohang as $key => $dotgiaohang){ ?>
        <li>
        	Đợt <?php echo $key + 1?>
            <input type="button" class="button" value="Xem" onclick="bmtn13.viewDotGiaoHang('<?php echo $dotgiaohang['id']?>','Đợt <?php echo $key + 1?>')"/>
           
            
            
            
            <?php if($dotgiaohang['bmtn13id']){?>
            BMTN13: <input type="button" class="button" value="<?php echo $dotgiaohang['sophieubmtn13']?>" onclick="bmtn13.view(<?php echo $dotgiaohang['bmtn13id']?>)"/>
            	<?php if($dotgiaohang['bmvt16id']==0){ ?>
                <?php if($this->user->checkPermission("bm/bmtn13/edit")==true){ ?>
            <input type="button" class="button" onclick="bmtn13.edit(<?php echo $dotgiaohang['id']?>,<?php echo $dotgiaohang['bmtn13id']?>)" value="Sửa"/>
            	<?php } ?>
            	<?php }?>
            <?php }else{ ?>
            <?php if($this->user->checkPermission("bm/bmtn13/create")==true){ ?>
            <input type="button" class="button" value="Lập phiếu yêu cầu kết quả khiểm nghiệm(BM-TN-13)" onclick="bmtn13.create('<?php echo $dotgiaohang['id']?>');"/>
            <?php } ?>
            <?php } ?>
            
            
        </li>
        <?php }?>
    </ul>