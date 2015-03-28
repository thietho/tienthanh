<table class="data-table">
	<tr>
    	
        <th>Tên sản phẩm</th>
        <th>Số lượng</th>
        <th>Giá</th>
        <th>Giảm(%)</th>
        <th>Giá khuyến mãi</th>
        
        <th>Hình</th>
        <th></th>
    </tr>
    
    <?php 
    if(count($medias))
    	foreach($medias as $key => $media){ ?>
    <tr class="item" mediaid="<?php echo $media['mediaid']?>">
    	
        <td><?php echo $this->document->productName($media)?></td>
        
        <td class="number">
        	<input id="qty<?php echo $media['mediaid']?>" col="qty" type="text" class="text number short ProductList" name="qty[<?php echo $media['mediaid']?>]" value="<?php echo $media['qty']?>" mediaid="<?php echo $media['mediaid']?>"/>
        </td>
        <td class="number">
            <input id="price<?php echo $media['mediaid']?>" col="price" type="text" class="text number short ProductList price" name="price[<?php echo $media['mediaid']?>]" value="<?php echo $media['price']?>" mediaid="<?php echo $media['mediaid']?>"/>
        </td>
        <td class="number">
            <input id="discountpercent<?php echo $media['mediaid']?>" col="discountpercent" type="text" class="text number short ProductList discountpercent" name="discountpercent[<?php echo $media['mediaid']?>]" value="<?php echo $media['discountpercent']?>" mediaid="<?php echo $media['mediaid']?>"/>
        </td>
        <td class="number">
            <input id="pricepromotion<?php echo $media['mediaid']?>" col="pricepromotion" type="text" class="text number short ProductList pricepromotion" name="pricepromotion[<?php echo $media['mediaid']?>]" value="<?php echo $this->string->numberFormate($media['pricepromotion'])?>" mediaid="<?php echo $media['mediaid']?>"/>
        </td>
        
        <td><img src="<?php echo $media['imagepreview']?>"></td>
        <td><input type="button" class="button" value="X" onClick="pro.removeListItem('<?php echo $media['mediaid']?>');"></td>
    </tr>
    <?php } ?>
</table>
<script language="javascript">
$(document).ready(function(e) {
    numberReady();
});

$('.price').keyup(function(e) {
    var mediaid = $(this).attr('mediaid');
	var price = stringtoNumber(this.value);
	var discountpercent = stringtoNumber($('#discountpercent'+mediaid).val());
	var pricepromotion = price * (1 - discountpercent/100);
	$('#pricepromotion'+mediaid).val(formateNumber(pricepromotion));
	
});
$('.discountpercent').keyup(function(e) {
    var mediaid = $(this).attr('mediaid');
	var price = stringtoNumber($('#price'+mediaid).val());
	var discountpercent = stringtoNumber(this.value);
	var pricepromotion = price * (1 - discountpercent/100);
	$('#pricepromotion'+mediaid).val(formateNumber(pricepromotion));
	if(discountpercent==0)
		$('#pricepromotion'+mediaid).val('0');
	
});
$('.pricepromotion').keyup(function(e) {
    var mediaid = $(this).attr('mediaid');
	var price = stringtoNumber($('#price'+mediaid).val());
	var pricepromotion = stringtoNumber(this.value);
	var discountpercent = (1- pricepromotion/price)*100;
	$('#discountpercent'+mediaid).val(formateNumber(discountpercent));
	if(pricepromotion==0)
		$('#discountpercent'+mediaid).val('0');
	
});
$('.ProductList').keyup(function(e) {
	var mediaid = $(this).attr('mediaid');
	pro.updateRowSelect(mediaid);
	/*$('.ProductList').each(function(index, element) {
        if($(this).attr('mediaid') == mediaid)
		{
			var col = this.id
			var val = this.value;
			$.get("?route=module/product/updateProductList",{
				mediaid:mediaid,
				col:col,
				val:stringtoNumber(val)
			});
		}
    });*/
    
	
});
</script>