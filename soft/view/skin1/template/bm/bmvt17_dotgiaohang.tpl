	<label>Đợt giao hàng</label>
    <ul>
    	<?php foreach($data_dotgiaohang as $key => $dotgiaohang){ ?>
        <li>
        	Đợt <?php echo $key + 1?>
            <input type="button" class="button" value="Xem" onclick="bmvt17.viewDotGiaoHang('<?php echo $dotgiaohang['id']?>','Đợt <?php echo $key + 1?>')"/>
           
            
            
            
            <?php if($dotgiaohang['bmvt17id']){?>
            BMVT17: <input type="button" class="button" value="<?php echo $dotgiaohang['sophieubmvt17']?>" onclick="bmvt17.view(<?php echo $dotgiaohang['bmvt17id']?>)"/>
            	<?php if($dotgiaohang['bmvt16id']==0){ ?>
                <?php if($this->user->checkPermission("bm/bmvt17/edit")==true){ ?>
            <input type="button" class="button" onclick="bmvt17.edit(<?php echo $dotgiaohang['id']?>,<?php echo $dotgiaohang['bmvt17id']?>)" value="Sửa"/>
            	<?php } ?>
            	<?php }?>
            <?php }else{ ?>
            <?php if($this->user->checkPermission("bm/bmvt17/create")==true){ ?>
            <input type="button" class="button" value="Lập phiếu cân hàng(BM-VT-17)" onclick="bmvt17.create('<?php echo $dotgiaohang['id']?>');"/>
            <?php } ?>
            <?php } ?>
            
            
        </li>
        <?php }?>
    </ul>