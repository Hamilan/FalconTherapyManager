   M S B A M L   `   `   `  ���� Q  MFalconGamingTherapyManager, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null?$clr-namespace:FalconGamingTherapyManagerFalconGamingTherapyManager  *    $FalconGamingTherapyManager.NewMainWindow   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     6local$clr-namespace:FalconGamingTherapyManager     X TXceed.Wpf.Toolkit, Version=2.4.0.0, Culture=neutral, PublicKeyToken=3e4669d2f30244f44xctk)http://schemas.xceed.com/wpf/xaml/toolkit  -     � Title$  Falcon Game Selector��$	��560��$	��763��.���� $
��Left=�$	��Top=� �� Orientation$ 
Horizontal=�.+�� $	��491��.+��� -    ��Name$ 	groupBox1��$��Selected game��$	��163��$	��482��$��Center=�$
��Bold"�.��� $��	0,10,-2,2q� � Orientation$ Vertical=�.+�� $
��Left=�$	��129��$	��Top=�$	��254��$��10,0,0,0q�.+��� -    ��Name$ selectedGameImage��$��44��$��Images/None.jpg���� -    ��Name$ selectedGameNameLabel��$��Name of selected game��$	��178��$
��Bold"�$��10,0,0,0q��� -   $ label2��$��How to play:���� -   $" selectedGameDescriptionLabel��$��60��$	��Top=�$
��Left=����� -    ��Name$ selectedGameInstructions�� �� TextWrapping$
 Wrap=�$(��"Select a game from the list below.�� �� 
FontWeight$ Normal"�� $
��Left=�$	��129��$	��Top=�.+��� -   $ falconUsageImage��$	��130��$��Images/selectAGame.png��$	��200���� -	   $ groupBoxBlueStacks��$��BlueStacks Games��$	��Top=�.���� $
��Left=�$	��230��$	��Top=�$��0,0,0,0q�.+��� 
���   �$��1q�$��46��._�� $��Center=�.+��� -
   $ image1��$��44��$'��!Images/LilMadsAndTheGoldSkull.png��	� -   	 	�Name$	 radioButton1��$!��Lil Mads and the Gold Skull��$	��180��$��40��$��Center=�
 	� 	GroupName$

 Game���� 
���   �$��1q�$��46��._�� $��44��.+��� -   $ image2��$��44��$ ��Images/LooneyTunesDash.png��	� -   $	 radioButton2��$��Looney Tunes Dash��$	��180��$��33��$��Center=�$

 Game���� 
���   �$��1q�$��46��._�� $��Center=�.+��� -   $ image3��$��44��$��Images/BusRush.png��	� -   $	 radioButton3��$��Bus Rush��$	��180��$��Center=�$��40��$

 Game���� 
���   �$��1q�$��46��._�� $��Center=�.+��� -   $ image4��$��44��$��Images/PacMan.png��	� -   $	 radioButton4��$��Pacman��$	��180��$��40��$��Center=�$

 Game���� 
���   �$��1q�$��46��._�� $��Center=�.+��� -   $ image5��$��44��$��Images/None.jpg��	� -   $	 radioButton5��$
��None��$	��180��$��40��$��Center=�$

 Game���� 
���   �$��1q�$��46��$��0,20,0,0q�._�� $��Center=�.+��� -   $ image6��$��44��$��Images/None.jpg��	� -   $	 radioButtonC8��$
��None��$	��180��$��40��$��Center=�$

 Game���� -   $ groupBoxChrome��$��Chrome Browser Games��$	��Top=�.���� $
��Left=�$	��230��$	��Top=�$��0,0,0,0q�.+��� 
���   �$��1q�$��46��._�� $��Center=�.+��� -   $ imageA��$��44��$ ��Images/HeroesOfTheLoot.PNG��	� -   $	 radioButtonA��$��Heroes of the Loot��$	��180��$��40��$��Center=�$

 Game���� 
���   �$��1q�$��46��._�� $��Center=�.+��� -   $ imageB��$��44��$��Images/SaveTheDay.png��	� -   $	 radioButtonB��$��Save the Day��$	��180��$��40��$��Center=�$

 Game���� 
���   �$��1q�$��46��._�� $��Center=�.+��� -   $ imageC��$��44��$��Images/BirdBrawl2.png��	� -   $	 radioButtonC��$��
Bird Brawl��$	��180��$��40��$��Center=�$

 Game���� 
���   �$��1q�$��46��._�� $��Center=�.+��� -   $ imageD��$��44��$��Images/HappyFriday.png��	� -   $	 radioButtonD��$��Happy Friday��$	��180��$��40��$��Center=�$

 Game���� 
���   �$��1q�$��46��._�� $��Center=�.+��� -   $ imageC2��$��44��$��Images/BounceBall.png��	� -    $	 radioButtonC2��$��Bounce Ball��$	��180��$��40��$��Center=�$

 Game���� 
���   �$��1q�$��46��._�� $��Center=�.+��� -!   $ imageE��$��44��$��Images/BallAndWall.png��	� -"   $	 radioButtonE��$��Ball and Wall��$	��180��$��40��$��Center=�$

 Game���� 
���   �$��1q�$��46��._�� $��Center=�.+��� -#   $ imageF��$��44��$��Images/Swoop.png��	� -$   $	 radioButtonF��$��Swoop��$	��180��$��40��$��Center=�$

 Game���� -%   $ groupBox��$��Falcon Settings��$	��256��$	��375��$	��Top=�$
��Bold"�.��� $
��Left=�$��5,10,0,0q�$	��Top=�$	��324��.+��� -&   $ label3_Copy2��$��Lift Weight��$	��117��$��Normal"��� -'    ��Name$ liftWeightTextBox��$
��Wrap=�$��0�� �� TextAlignment$ Right=�$��30��$��Center=�$��Normal"��� -(    ��Name$ liftWeightSlider��$	��234�� � Maximum$	 100Q��� $��0q�$	��230��$��30���� -)   $ moveResistanceLabel��$��Move resistance��$	��117��$��Normal"��� -*   $ moveResistanceTextBox��$
��Wrap=�$��0��$ Right=�$��30��$��Center=�$��Normal"��� -+   $ moveResistanceSlider��$	��234��$	 100Q��� $��0q�$	��230��$��30���� -,   $ pushResistanceLabel��$��Push resistance��$	��117��$��Normal"��� --   $ pushResistanceTextBox��$
��Wrap=�$��0��$ Right=�$��30��$��Center=�$��Normal"��� -.   $ pushResistanceSlider��$	��234��$	 100Q��� �� $��0q�$	��230��$��30���� -/    ��Name$ 
easyButton��$
��Easy��$��75��$��Normal"��� -0   $ MediumButton��$��Medium��$��75��$	��5,0q�$��Normal"��� -1   $ 
hardButton��$
��Hard��$��75��$��Normal"�