<?php foreach($datas as $item){ ?>
<div style="border:thin solid;width:250px;margin-top:5px;">
    <label>ID:</label> <?php echo $item['id']?><br />
    <label>Mã nguyên vật liệu:</label> <?php echo $this->document->getNguyenLieu($item['itemid'],"manguyenlieu")?><br />
    <label>Tên nguyên vật liệu:</label> <?php echo $item['itemname']?><br /> 
    <label>Số lượng:</label> <?php echo $this->string->numberFormate($item['thucnhap'],0)?> <?php echo $this->document->getDonViTinh($item['madonvi'])?><br /> 
</div>
<?php } ?>
<script language="javascript">
	window.print();
</script>