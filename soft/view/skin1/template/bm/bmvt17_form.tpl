<h2>Phiếu cân hàng</h2>
<div id="error" class="error hidden"></div>
<form id="frm_bmvt17">
	
    <p>
    	<input type="hidden" id="id" name="id" value="<?php echo $item['id']?>"/>
        <input type="hidden" id="bmtn13id" name="bmtn13id" value="<?php echo $item['bmtn13id']?>"/>
        Đơn vị giao hàng: <?php echo $item['tennhacungung']?>
        <input type="hidden" id="nhacungungid" name="nhacungungid" value="<?php echo $item['nhacungungid']?>"/>
        <input type="hidden" id="manhacungung" name="manhacungung" value="<?php echo $item['manhacungung']?>"/>
        <input type="hidden" id="tennhacungung" name="tennhacungung" value="<?php echo $item['tennhacungung']?>"/>
        
    </p>
    <?php if(count($data_ct)){ ?>
    <?php foreach($data_ct as $key => $ct){ ?>
    <h3><?php echo $ct['itemname']?> số lượng giao <?php echo $ct['soluong']?> <?php echo $this->document->getDonViTinh($ct['madonvi'])?></h3>
    <input type="button" class="button" value="Thêm lần cân" onclick="bmvt17.addRow(<?php echo $ct['itemid']?>)"/>
    <table>
    	<thead>
        	<tr>
                <th>Bao bì</th>
                <th>Loại bao</th>
                <th>Số lượng</th>
                
                <th>Ghi chú</th>
            </tr>
        </thead>
        <tbody id="listcan<?php echo $ct['itemid']?>"></tbody>
    </table>
    <?php } ?>        
    <?php }?>
    
</form>
<script language="javascript">
numberReady();
function BMVT17()
{
	this.index = 0;
	this.baobi = "";
	this.loaibao = "";
	this.soluongcan = 0;
	
	this.ghichu = "";
	this.addRow = function(itemid)
	{
		var row = '<tr>';
		//Bao bi
		row += '<td><input type="text" class="text" id="baobi-'+ this.index +'" name="baobi['+ itemid +']['+ this.index +']" value="'+ this.baobi +'"></td>';
		//Loai bao
		row += '<td><input type="text" class="text " id="loaibao-'+ this.index +'" name="loaibao['+ itemid +']['+ this.index +']" value="'+ this.loaibao +'"></td>';
		//So luong can
		row += '<td><input type="text" class="text number" id="soluongcan-'+ this.index +'" name="soluongcan['+ itemid +']['+ this.index +']" value="'+ this.soluongcan +'"></td>';
		//Ghi chu
		row += '<td><input type="text" class="text" id="ghichu-'+ this.index +'" name="ghichu['+ itemid +']['+ this.index +']" value="'+ this.ghichu +'"></td>';
		row += '</tr>';
		$('#listcan'+itemid).append(row);
		numberReady();
	}
		
}
var bmvt17 = new BMVT17();

</script>