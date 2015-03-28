<form id="frm_sortproduct">
	<input type="hidden" name="sort" value="<?php echo 'sort'.$this->request->get['sitemapid'].$this->request->get['status'].$this->request->get['brand']?>">
    <?php foreach($medias as $key => $media) {?>
    <div class="product-item left" ref="<?php echo $media['mediaid']?>" style="background:url('<?php echo $media['imagepreview']?>') no-repeat center center;">
        <input type="hidden" class="listid" name="mediaid[]" value="<?php echo $media['mediaid']?>">
        <table height="100%">
            
            <tr valign="middle">
                <td align="center">
                    <?php echo $this->document->productName($media)?><br />
                    <!--Giảm: <?php echo $this->string->numberFormate($media['discountpercent'])?>%<br />
                    Giá: <?php echo $this->string->numberFormate($media['price'])?><br />
                    Giá khuyến mãi: <?php echo $this->string->numberFormate($media['pricepromotion'])?><br />
                    Tồn: <?php echo $media['tonkho']?>-->
                </td>
            </tr>
        </table>
    </div>
    <?php }?>
</form>
<div class="clearer">^&nbsp;</div>
<script language="javascript">
$(document).ready(function(e) {
    //$('#frm_sortproduct').sortable();
	//$( "#frm_sortproduct" ).disableSelection();
	$('#frm_sortproduct').on("click",'div',function(e){
		if (e.ctrlKey || e.metaKey) {
			$(this).toggleClass("selected");
		} else {
			$(this).addClass("selected").siblings().removeClass('selected');
		}	
	}).sortable({
    connectWith: "#frm_sortproduct",
    delay: 150, //Needed to prevent accidental drag when trying to select
    revert: 0,
    helper: function (e, item) {
        //Basically, if you grab an unhighlighted item to drag, it will deselect (unhighlight) everything else
        if (!item.hasClass('selected')) {
            item.addClass('selected').siblings().removeClass('selected');
        }

        //////////////////////////////////////////////////////////////////////
        //HERE'S HOW TO PASS THE SELECTED ITEMS TO THE `stop()` FUNCTION:

        //Clone the selected items into an array
        var elements = item.parent().children('.selected').clone();

        //Add a property to `item` called 'multidrag` that contains the 
        //  selected items, then remove the selected items from the source list
        item.data('multidrag', elements).siblings('.selected').remove();

        //Now the selected items exist in memory, attached to the `item`,
        //  so we can access them later when we get to the `stop()` callback

        //Create the helper
        var helper = $('<div/>');
        return helper.append(elements);
    },
    stop: function (e, ui) {
        //Now we access those items that we stored in `item`s data!
        var elements = ui.item.data('multidrag');

        //`elements` now contains the originally selected items from the source list (the dragged items)!!

        //Finally I insert the selected items after the `item`, then remove the `item`, since 
        //  item is a duplicate of one of the selected items.
        ui.item.after(elements).remove();
    }

});
	$.ui.sortable.prototype._rearrange = function (event, i, a, hardRefresh) 
	{
						
		a ? a[0].appendChild(this.placeholder[0]) : (i.item[0].parentNode) ? i.item[0].parentNode.insertBefore(this.placeholder[0], (this.direction === "down" ? i.item[0] : i.item[0].nextSibling)) : i.item[0];
		this.counter = this.counter ? ++this.counter : 1;
		var counter = this.counter;
	
		this._delay(function () {
			if (counter === this.counter) {
				this.refreshPositions(!hardRefresh); //Precompute after each DOM insertion, NOT on mousemove
			}
		});
	
	}
});
</script>