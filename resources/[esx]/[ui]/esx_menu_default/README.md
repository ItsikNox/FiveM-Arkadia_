# ESX MENU DEFAULT GTA ONLINE STYLE


### How to use :

source : https://github.com/ESX-Org/esx_menu_default
little exemple: 

 

    ESX.UI.Menu.Open(
    
    'default', GetCurrentResourceName(), 'shop',
    
    {
    
    css =  'superete',
    
    title =  'Magasin',
    
    elements = elements
    
    },
    
    function(data, menu)
    
    TriggerServerEvent('esx_shop:buyItem', data.current.value, data.current.price)
    
    end,
    
    function(data, menu)
    
      
    
    menu.close()
    
      
    
    CurrentAction =  'shop_menu'
    
    CurrentActionMsg =  _U('press_menu')
    
    CurrentActionData = {zone = zone}
    
    end
    
    )

css = 'superete' matches with 

        .menu .head_superete{
    
    font-family: SignPainter;
    
    font-size: 59px;
    
      
    
    background-image: url("../img/header/247.png");
    
    text-align : center;
    
    height : 90px;
    
    line-height : 105px;
    
    color : white;
    
    font-style: oblique;
    
    }

and it looks like this 
![Menu esx_shops (not perfect)](https://i.gyazo.com/c60d33351078f2c04a606c397e9a704a.png)

everything is possible : 
![Menu Exemple](https://i.gyazo.com/8d2713daca657ce3eab729a03e293df9.png)
![Exemple](https://i.gyazo.com/10df6a7551488e3b5a6741a12afa7946.png)
![Exemple](https://i.gyazo.com/9fd978ab07fdde2e7c68f5fa70555b7f.png)

To edit some header there is the template.psd but there is a lot of header in img folder

