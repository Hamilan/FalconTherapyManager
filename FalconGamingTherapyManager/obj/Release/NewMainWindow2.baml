   M S B A M L   `   `   `  ���� Q  MFalconGamingTherapyManager, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null?$clr-namespace:FalconGamingTherapyManagerFalconGamingTherapyManager  +    %FalconGamingTherapyManager.NewMainWindow2   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     6local$clr-namespace:FalconGamingTherapyManager     X TXceed.Wpf.Toolkit, Version=2.4.0.0, Culture=neutral, PublicKeyToken=3e4669d2f30244f44xctk)http://schemas.xceed.com/wpf/xaml/toolkit  -     � Title$(  "Falcon Game and Resistance Manager��$��646.037��$��836.445�����	#FFEAEAEA.���� $
��Left=�$	��Top=� �� Orientation$ 
Horizontal=�$	��819��.+�� $	��342��.+��� -    ��Name$ profileGroupBox��$$��Participant's Profile Settings��$	��Top=�$
��Bold"�$	��330��$��0q�
�������.��� $��Center=�$��0,10,0,0q�$	��Top=�.+��� -    ��Name$ profile��$��70��$��Images/profile.jpg��� $��	5,10,-2,0q�$	��Top=�$��60��$	��155��.+��� -    ��Name$ 	UserLabel��$��User:��$��77���� -    ��Name$ usernameTextBlock��$��22�� �� TextWrapping$
 Wrap=�$��Default��$��Normal"�$	��140��$��10,0,0,0q�� $��5,10,0,0q�$	��Top=�$��85��.+��� -    ��Name$ openProfileButton��$��Open profile��$��85��$��30��$��Normal"��� -   $ saveProfileButton��$��Save profile��$��85��$��30��$
��0,10q�$��Normal"��� $��15,5,5,5q�$	��280��$��Center=�
���   ����	#FF494646�� -   $ labelThreshold��$��Range of wrist extension:��$	��149��$��30��$��Normal"�$��Center=�$��10,0,0,0q��� -	    ��Name$ thresholdTextBox��$
��Wrap=�$��0��$��60��$��Center=�$��Normal"��� -
   $ setWristRangeButton��$��	Calibrate��$��75��$��30��$��Normal"�$��
10,0,10,10q�$��Center=��� $��15,5,5,5q�$	��280��$��Center=�
���   ����	#FF494646�� -   $ label3_Copy2��$��Falcon' s resistance:��$	��120��$��Normal"�$��10,0,0,0q��� -   $ liftWeightTextBox��$
��Wrap=�$��0��$��97��$��Center=�$��Normal"�$
��Left=��� -   	 ��Name$	 liftWeightSlider��$	��290��
 � Maximum$

 1000Q�$��30��$
��10,0q� � Value$	 500Q� � LargeChange$ 10Q� � SmallChange$ 1Q��� -   $ 
easyButton��$
��Easy��$��75��$��30��$��Normal"�$��
10,0,10,10q��� -   $ MediumButton��$��Medium��$��75��$��
20,0,20,10q�$��Normal"��� -   $ 
hardButton��$
��Hard��$��75��$��Normal"�$��
10,0,10,10q��� -   $ 	groupBox1��$"��Selected game and game style��$	��308��$	��327��$��Center=�$
��Bold"�
�������$��	10,10,0,0q�.���  � Orientation$ Vertical=�$��Center=�$	��Top=�$	��220��$��0q�.+��� -   $ label2��$��How to play:��$��28��$	��220��$��0,10,0,0q��� -   $" selectedGameDescriptionLabel��$��60��$	��Top=�$
��Left=�.���� -    ��Name$ selectedGameInstructions�� �� TextWrapping$
 Wrap=�$3��-Select a game style or a game from the right.�� �� 
FontWeight$ Normal"�$��50��$	��220���� -   $ falconUsageImage��$	��130��$��Images/SelectAGame.png��$	��200��$��Center=�$��0,0,0,5q��� 
���   �$��1q�$	��145��._�	� -    	�Name$ radioButton5��$��Reset/use no game��$	��145��$��40��$��Center=� 	� 	GroupName$
 Game�� d� 	IsChecked$
 TrueY�� $	��480��$��0q�.+��� -   $ liftGamesGroupBox��$��Jump/Lift/Up-Down games��$	��317��$	��470��$��Center=�$
��Bold"�
������� � ToolTip$- 'Click to active lift/up-down games mode��$��0q�.��� $��	0,10,-2,2q�$ Vertical=�.+��� 
���   �$��1q�$	��205��$��0,30,0,0q�._�� $��5,0,0,0q�.+��� -   $ falconUsageImage2��$	��130��$#��Images/FalconUpDownButton.png��$	��200��	� -   $! radioButtonLiftFalconOption��$!��Use jump/lift/up-down games��$	��205��$��40��$��Center=�$
 Game��� $
��Left=�$	��Top=�$	��215��$��10,0,0,0q�.+��� -   $ ChromeGamesLabel��$��Games��$	��215��$��30��$��Bottom=�$
��Left=�
��������� -   $ imageCrazyRider��$��44��$��Images/CrazyRiderIcon.jpg���� -   $ buttonCrazyRider��$��Crazy Rider��$	��170��$��40��$��Center=�$ Click to launch the game���� -   $ imageFunkyKarts��$��44��$��Images/FunkyKarts.jpg���� -   $ buttonFunkyKarts��$��Funky Karts��$	��170��$��40��$��Center=�$ Click to launch the game���� -   $ image1��$��44��$+��%Images/LilMadsAndTheGoldSkullIcon.jpg���� -    $ buttonLilMads��$!��Lil Mads and the Gold Skull��$	��170��$��40��$��Center=�$ Click to launch the game���� -!   $ imageF1��$��44��$��Images/Swoop.png���� -"   $ buttonSwoop��$��Swoop��$	��170��$��40��$��Center=�$ Click to launch the game���� -#   $ TestGameLabel��$��Wrist Assessment Game��$	��215��$��30��$��Bottom=�$
��Left=�
��������� -$   $ imageTestGame��$��44��$��Images/profile.jpg���� -%   $ buttonAssessmentGameStart��$��Start��$��80��$��40��$��Center=�$ Click to launch the game���� -&   $ buttonAssessmentGameStop��$
��Stop��$��80��$��40��$��Center=�$$ Click to stop logging the game��$��10,0,0,0q��� -'   $ moveAroundGamesGroupBox��$��Move around games��$��Center=�$
��Bold"�$	��470��$	��286��
�������$, &Click to active move-around games mode��.��� $��	0,10,-2,0q�$ Vertical=�$	��Top=�.+��� 
���   �$��1q�$	��205��$��	0,30,0,50q�$��Center=�._�� .+��� -(   $ falconUsageImage3��$	��130��$ ��Images/FalconPanButton.png��$	��200��$��Center=�	� -)   $  radioButtonPanFalconOption��$��Use move around games��$	��180��$��40��$��Center=�$
 Game��$��0q�$��Center=�� $
��Left=�$	��Top=�$	��215��$��10,0,0,0q�.+��� -*   $ ChromeGamesLabel2��$��Games��$	��215��$��30��$��Bottom=�$
��Left=�
��������� -+   $ imageA��$��44��$ ��Images/HeroesOfTheLoot.png���� -,   $ buttonHeroes��$��Heroes of the Loot��$	��170��$��40��$��Center=�$ Click to launch the game���� --   $ imageB��$��44��$��Images/SaveTheDay.png���� -.   $ buttonSaveTheDay��$��Save the Day��$	��170��$��40��$��Center=�$ Click to launch the game���� -/   $ imageC��$��44��$��Images/BirdBrawl2.png���� -0   $ buttonBirdBrawl��$��
Bird Brawl��$	��170��$��40��$��Center=�$ Click to launch the game���� -1   $ image4��$��44��$��Images/PacMan.png���� -2   $ buttonPacman��$��Pacman��$	��170��$��40��$��Center=�$ Click to launch the game��� $
��Left=�$	��Top=�$	��215��$��10,0,0,0q�$8 2These games need to be launched through BlueStacks��.+��� -3   $ image2��$��44��$ ��Images/LooneyTunesDash.png���� -4   $ buttonLooneyTunes��$��Looney Tunes Dash��$	��170��$��40��$��Center=�$ Click to launch the game��