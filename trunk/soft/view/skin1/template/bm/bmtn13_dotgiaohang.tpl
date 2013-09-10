	<label>Đợt giao hàng</label>
    <ul>
    	<?php foreach($data_dotgiaohang as $key => $dotgiaohang){ ?>
        <li>
        	Đợt <?php echo $key + 1?>
            <input type="button" class="button" value="Xem" onclick="bm.viewDotGiaoHang('<?php echo $dotgiaohang['id']?>','Đợt <?php echo $key + 1?>')"/>
            <?php if($dotgiaohang['bmtn13id']==0 && $dotgiaohang['bmvt17id']==0 && $dotgiaohang['bmvt16id']==0){?>
            <?php if($this->user->checkPermission("bm/bmvt03/delDotGiaoHang")==true){ ?>
            <input type="button" class="button" value="Xóa" onclick="bm.delDotGiaoHang('<?php echo $dotgiaohang['id']?>','<?php echo $item['id']?>')"/>
            <?php } ?>
            <?php } ?>
            
            
            
            <?php if($dotgiaohang['bmtn13id']){?>
            BMTN13: <input type="button" class="button" value="<?php echo $dotgiaohang['sophieubmtn13']?>" onclick="bm.viewBMTN13(<?php echo $dotgiaohang['bmtn13id']?>)"/>
            	<?php if($dotgiaohang['bmvt16id']==0){ ?>
                <?php if($this->user->checkPermission("bm/bmtn13/edit")==true){ ?>
            <input type="button" class="button" onclick="ktdv.loadData('?route=bm/bmtn13/edit&id=<?php echo $dotgiaohang['bmtn13id']?>&dotgiaohangid=<?php echo $dotgiaohang['id']?>')" value="Sửa"/>
            	<?php } ?>
            	<?php }?>
            <?php }else{ ?>
            <?php if($this->user->checkPermission("bm/bmtn13/create")==true){ ?>
            <input type="button" class="button" value="Lập phiếu yêu cầu kết quả khiểm nghiệm(BM-TN-13)" onclick="ktdv.loadData('?route=bm/bmtn13/create&dotgiaohangid=<?php echo $dotgiaohang['id']?>');"/>
            <?php } ?>
            <?php } ?>
            
            <?php if($dotgiaohang['bmvt17id']){?>
            BMVT17: <input type="button" class="button" value="<?php echo $dotgiaohang['sophieubmvt17']?>" onclick="bm.viewBMVT17(<?php echo $dotgiaohang['bmvt17id']?>)"/>
            	<?php if($dotgiaohang['bmvt16id']==0){ ?>
                <?php if($this->user->checkPermission("bm/bmvt17/edit")==true){ ?>
            <input type="button" class="button" onclick="ktdv.loadData('?route=bm/bmvt17/edit&id=<?php echo $dotgiaohang['bmvt17id']?>&dotgiaohangid=<?php echo $dotgiaohang['id']?>')" value="Sửa"/>
            	<?php } ?>
            	<?php } ?>
            <?php }else{ ?>
            <?php if($this->user->checkPermission("bm/bmvt17/create")==true){ ?>
            <input type="button" class="button" value="Lập phiếu cân hàng(BM-VT-17)" onclick="ktdv.loadData('?route=bm/bmvt17/create&dotgiaohangid=<?php echo $dotgiaohang['id']?>');"/>
            <?php } ?>
            <?php } ?>
            
            <?php if($dotgiaohang['bmtn13id'] !=0 && $dotgiaohang['bmvt17id']!=0){ ?>
            	<?php if($dotgiaohang['bmvt16id']){ ?>
            BMVT16: 
            <input type="button" class="button" value="<?php echo $dotgiaohang['sophieubmvt16']?>"  onclick="bm.viewBMVT16(<?php echo $dotgiaohang['bmvt16id']?>)"/>
            <?php if($this->user->checkPermission("bm/bmvt16/edit")==true){ ?>
            <input type="button" class="button" onclick="ktdv.loadData('?route=bm/bmvt16/edit&id=<?php echo $dotgiaohang['bmvt16id']?>&dotgiaohangid=<?php echo $dotgiaohang['id']?>')" value="Sửa"/>
            <?php } ?>
                <?php }else{ ?>
                <?php if($this->user->checkPermission("bm/bmvt16/create")==true){ ?>
                <input type="button" class="button" value="Lập phiếu nhập vật tư hàng hóa(BM-VT-16)" onclick="ktdv.loadData('?route=bm/bmvt16/create&dotgiaohangid=<?php echo $dotgiaohang['id']?>');"/>
                <?php } ?>
                <?php } ?>
            <?php } ?>
        </li>
        <?php }?>
    </ul>