<form id="frm_dotgiaohang">

<input type="hidden" id="id" name="id" value="<?php echo $item['id']?>"/>
<p>
	<label>Số phiếu</label>
    <?php echo $item['sophieu']?>
</p>
<p>
	<label>Ngày lập phiếu</label>
    <?php echo $this->date->formatMySQLDate($item['ngaylapphieu'])?>
</p>
<p>
	<label>Tình trạng</label>
    <?php echo $arr_pheduyet[$item['tinhtrang']]?>
</p>
<p>
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
</p>
<?php if($this->user->checkPermission("bm/bmvt03/createDotGiaoHang")==true){ ?>
<input type="button" class="button" id="btn_TaoDotGiaHang" value="Tạo đợt giao hàng">
<?php } ?>
<table class="table-data">
	<thead>
        <tr>
            <th rowspan="2">STT</th>
            <th rowspan="2">Tên hàng và qui cách</th>
            <th rowspan="2">ĐVT</th>
            <th colspan="2">Tồn hiện tại</th>
            <th colspan="2">Qui dịnh</th>
            <th rowspan="2"  width="135px">Phê duyệt</th>
            <th rowspan="2">Đã giao</th>
            <th rowspan="2">Còn lại</th>
            <th rowspan="2">T/G yêu cầu cung ứng</th>
            <th rowspan="2">Phản hồi T/G cung ứng</th>
            <th rowspan="2">Kết quả thực hiện</th>
            <th rowspan="2">Mục đích sử dụng</th>
        </tr>
        <tr>
          <th>Vật tư</th>
          <th>Linh kiện</th>
          <th>Tồn T/thiểu</th>
          <th>Mua T/thiểu</th>
        </tr>
        
    </thead>
    <tbody>
    	<?php if(count($data_ct)){ ?>
			<?php foreach($data_ct as $key => $ct){ ?>
    	<tr>
        	<td><?php echo $key + 1 ?></td>
            <td><?php echo $ct['itemname']?></td>
            <td><?php echo $this->document->getDonViTinh($ct['madonvi'])?></td>
            <td class="number"></td>
            <td class="number"></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['tontonthieu'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['muatoithieu'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['pheduyet'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['dagiao'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['conlai'])?></td>
            <td align="center"><?php echo $this->date->formatMySQLDate($ct['thoigiayeucau'])?></td>
            <td align="center">
            	<?php echo $this->date->formatMySQLDate($ct['thoigianphanhoi'])?>
            </td>
            <td><?php echo $ct['ketquathuchien']?></td>
            <td><?php echo $ct['mucdichsudung']?></td>
        </tr>
        	<?php } ?>
        <?php } ?>
    </tbody>
   
</table>

</form>
<script language="javascript">
	numberReady();
$('#btn_TaoDotGiaHang').click(function(e) {
    ktdv.loadData("?route=bm/bmvt03/createDotGiaoHang&bmvt03id=<?php echo $item['id']?>");
});
</script>