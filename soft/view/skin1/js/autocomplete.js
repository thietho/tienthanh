// JavaScript Document
//Autocomplete
function AutoComplete()
{
	this.curentRow = 0;
	
	this.closeAutocomplete = function()
	{
		$("#autocomplete").hide();
		$("#autocomplete").html("");
	};
	
	this.selectRow = function()
	{
		$(".autocompleterow").removeClass("selectrow");
		$("#rowauto-" + this.curentRow).addClass("selectrow");
	};
	
	this.back = function()
	{
		if(this.curentRow>0)
		{
			this.curentRow--;
			this.selectRow();
		}
	}
	
	this.next = function()
	{
		
		if($("#rowauto-"+ (this.curentRow + 1)).html() != null)
		{
			this.curentRow++;
			this.selectRow();
		}
	}
	
	this.getValue = function()
	{
		arr = new Array();
		if($("#rowauto-"+ this.curentRow ).html()!=null)
		{
			str = $("#rowauto-"+ this.curentRow ).html();
			
			
		}
		return str;
	}
	
	this.autocomplete = function()
	{
		$(".gridautocomplete").change( function()
		{ 
			selectValue(this.id);
		});
		
		$(".gridautocomplete").keyup(function(event)
		{
			//Press enter
			if (event.keyCode == '13')
			{
				selectValue(this.id);
			}
			//Press button down
			if (event.keyCode == '40')
			{
				auto.next();
				
			}
			//Press button up
			if (event.keyCode == '38')
			{
				auto.back();
			}
			
			if(event.keyCode > 40 || event.keyCode == 8)
			{
				
				position = $(this).position();
				$("#autocomplete").css("left", position.left + "px");
				$("#autocomplete").css("top", position.top+ 35 + "px");
				$("#autocomplete").show();
				if($(this).val() != "")
				{
					callBackAutoComplete(this);
					
					auto.curentRow = 0;
				}
				else
					auto.closeAutocomplete()
			}
		});
		
		
	};
	
	
}