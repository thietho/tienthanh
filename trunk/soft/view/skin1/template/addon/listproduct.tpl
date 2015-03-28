<?php foreach($medias as $media){ ?>
<?php if(count($media['child'])==0){ ?>
<div class="product-item left price-item" ref="<?php echo $media['mediaid']?>" image="<?php echo $media['imagepreview']?>" code="<?php echo $media['code']?>" unit="<?php echo $media['unit']?>" title="<?php echo $this->document->productName($media)?>" price="<?php echo $media['price']?>" pricepromotion="<?php echo $media['pricepromotion']?>" style="background:url('<?php echo $media['imagepreview']?>') no-repeat center center;">
    <input type="hidden" class="listid" value="<?php echo $media['mediaid']?>">
	<table height="100%">
    	
        <tr valign="middle">
        	<td align="center">
            	<?php echo $this->document->productName($media)?><br />
                
                Giá: <?php echo $this->string->numberFormate($media['price'])?><br />
                Giá khuyến mãi: <?php echo $this->string->numberFormate($media['pricepromotion'])?><br />
                Tồn: <?php echo $media['tonkho']?>
            </td>
        </tr>
    </table>
</div>
<?php }?>
<?php }?>
<div class="clearer">^&nbsp;</div>
