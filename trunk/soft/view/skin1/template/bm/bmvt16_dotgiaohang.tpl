	<label>Đợt giao hàng</label>
    <ul>
    	<?php foreach($data_dotgiaohang as $key => $dotgiaohang){ ?>
        <li>
        	Đợt <?php echo $key + 1?>
            <input type="button" class="button" value="Xem" onclick="bmvt16.viewDotGiaoHang('<?php echo $dotgiaohang['id']?>','Đợt <?php echo $key + 1?>')"/>
           	
            <?php if($dotgiaohang['bmtn13id']){?>
            BMTN13:
            <input type="button" class="button" value="<?php echo $dotgiaohang['sophieubmtn13']?>" onClick="bmvt16.viewBMTN13('<?php echo $dotgiaohang['bmtn13id']?>')">
            <?php } ?>
            <?php if($dotgiaohang['bmvt17id']){?>
            BMVT17:
            <input type="button" class="button" value="<?php echo $dotgiaohang['sophieubmvt17']?>" onClick="bmvt16.viewBMVT17('<?php echo $dotgiaohang['bmvt17id']?>')">
            <?php } ?>
            
            <?php if($dotgiaohang['bmtn13id'] && $dotgiaohang['bmvt17id']){ ?>
            <?php if($dotgiaohang['bmvt16id']){?>
            BMVT16: <input type="button" class="button" value="<?php echo $dotgiaohang['sophieubmvt17']?>" onclick="bmvt16.view(<?php echo $dotgiaohang['bmvt16id']?>)"/>
            	
            <?php }else{ ?>
            <?php if($this->user->checkPermission("bm/bmvt16/create")==true){ ?>
            <input type="button" class="button" value="Lập phiếu nhập vật tư hàng hóa(BM-VT-16)" onclick="bmvt16.create('<?php echo $dotgiaohang['id']?>');"/>
            <?php } ?>
            <?php } ?>
            <?php } ?>
            
            
            
        </li>
        <?php }?>
    </ul>