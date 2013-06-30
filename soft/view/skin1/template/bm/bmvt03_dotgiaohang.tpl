<form id="frm_dotgiaohang">
<p>&nbsp;</p>
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
<input type="button" class="button" id="btn_TaoDotGiaHang" value="Tạo đợt giao hàng">
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
            <td class="number"></td>
            <td class="number"></td>
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