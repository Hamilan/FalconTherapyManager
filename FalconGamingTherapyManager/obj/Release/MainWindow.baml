   M S B A M L   `   `   `  ���� Q  MFalconGamingTherapyManager, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null?$clr-namespace:FalconGamingTherapyManagerFalconGamingTherapyManager  '    !FalconGamingTherapyManager.MainWindow   W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     6local$clr-namespace:FalconGamingTherapyManager     :xctk)http://schemas.xceed.com/wpf/xaml/toolkit     -     � Title$#  Falcon Gaming-Therapy Manager��$	��870�����	#FFEAEAEA$��866.571�� � 
ResizeMode$ 	CanResize=�.���� $
��Left=�$	��Top=� �� Orientation$ 
Horizontal=�$	��850��.+�� $	��355��.+��� -    ��Name$ MainGroupBox��$��Patient's Profile��$	��Top=�$��0q�
�������.��� $
��10,0q�$	��Top=�.+�� $��	0,10,10,0q�$	��Top=�$��85��.+��� -    ��Name$ openProfileButton��$��Open a profile��$��85��$��30���� -   $ saveProfileButton��$��Create profile��$��85��$��30��$	��0,5q��� -    ��Name$ profile��$��60��$��Images/profile.jpg��� $��5,10,0,0q�$	��Top=�$	��148��.+��� -    ��Name$ 	UserLabel��$��User:��$��50���� -   $ usernameTextBlock��$��25��$��Default��$��90��$��5,0,0,0q��� -   $ SessionLabel��$��Session:��$��50���� -	   $ sessionTextBlock��$��25��$��0��$��90��$��5,0,0,0q��� -
   $ settingsGroupBox��$��Profile settings��$	��Top=�
�������{�.  .��� $��Center=�.+�	� -    	�Name$" radioButtonTurnOffResistance��$ ��Turn off resistance/weight��$	��175��$��30��$��Center=� 	� 	GroupName$
 Game��$
��15,5q�	� -   $ radioButtonWristOption��$��Work with wrist extension��$	��320��$��30��$
��10,0q�$��Center=�$
 Game��	 � ToolTip$C	 =Click to adjust settings associated with Wrist extension play���� -   $ wristSettingsGroupBox��$��Wrist Extension Settings��$	��Top=�.��� $��Center=�.+��� -   $ weightLabel��$	��110��$��Falcon's weight���� -   $ liftWeightTextBox��$��90��$��	500 grams���� -   
 ��Name$
 liftingWeightSlider��$	��300�� � Maximum$
 1000Q�$��25��$
��10,0q� � Value$	 500Q� � LargeChange$	 100Q� � SmallChange$ 10Q���.  �� -   $ easyWeightButton��$
��Easy��$��60��$��30��$��	30,0,10,0q��� -   $ mediumWeightButton��$��Medium��$��60��$��	30,0,30,0q��� -   $ hardWeightButton��$
��Hard��$��60��$��15,0,0,0q��� $	��290��$
��20,0q�$��20���� -   $ labelThreshold��$��Maximum wrist extension:��$	��150��$��30��$��Center=��� -    ��Name$ liftThresholdTextBox��$��0��$��60��$��Center=� �� TextAlignment$ Right=��� -   $ setWristRangeButton��$��Start measure��$��85��$��30��$��10,0,0,0q�$��Center=��� -   $ labelTolerance��$7��1Percentage of maximum extension required to play:��$	��285���� -   $ liftingRequiredLabel��$��40��$
��100%���� -   $
 liftingRequiredSlider��$	��300��$	 100Q� � Minimum$ 50Q�$��20��$
��10,0q�$ 90Q�$ 10Q�$ 1Q���.  �� -   $ minWristLabel��$	��50%��$��0q�$��	5,0,265,0q��� -   $ maxWristLabel��$
��100%��$��0q�	� -   $$ radioButtonElbowShoulderOption��$'��!Work with elbow/shoulder movement��$	��300��$��30��$
��10,0q�$��Center=�$
 Game��$K	 EClick to adjust settings associated with shoulder/elbow movement play���� -   $# elbowShoulderSettingsGroupBox��$'��!Elbow/shoulder Extension Settings��$	��Top=�.��� $��Center=�.+��� -   $ resistanceLabel��$	��110��$��Center=�$��Falcon's resistance:���� -   $ movingResistanceLabel��$��90��$��Center=�$��	500 grams���� -    $
 moveResistanceSlider��$	��300��$
 1000Q�$��30��$
��10,0q�$	 500Q�$ 10Q�$ 1Q���.  �� -!   $ easyResistanceButton��$
��Easy��$��60��$��25��$��	30,0,10,0q��� -"   $ mediumResistanceButton��$��Medium��$��60��$��	30,0,30,0q��� -#   $ hardResistanceButton��$
��Hard��$��60��$��15,0,0,0q��� $	��290��$
��20,0q�$��20���� -$   $ labelMoveThreshold��$'��!Range of elbow/shoulder movement:��$	��210��$��30��$��Center=��� -%   $ setMoveRangeButton��$��Start measure��$��85��$��30��$��8,0,0,0q�$��Center=�� $��70,0,0,0q�$��Center=�$	��180��$	��110������  �� ImageSource$ Images/FalconBG.png�� j� Stretch$ Uniform=�.+��� -&   $ moveThresholdTextBoxUp��$��0��$��60��$��	70,10,0,0q�$ Center=�
��������� -'   $ moveThresholdTextBoxLeft��$��0��$��60��$��	10,20,0,0q�$ Center=�
��������� -(   $ moveThresholdTextBoxRight��$��0��$��60��$��	50,20,0,0q�$ Center=�
��������� -)   $ moveThresholdTextBoxDown��$��0��$��60��$��	70,20,0,0q�$ Center=�
��������� -*   $ labelTolerancePan��$7��1Percentage of maximum extension required to play:��$	��285���� -+   $ movementRequiredLabel��$��40��$
��100%���� -,   $
 movementRequiredSlider��$	��300��$	 100Q�$ 50Q�$��20��$
��10,0q�$ 90Q�$ 10Q�$ 1Q���.  �� --   $ minMovementLabel��$	��50%��$��0q�$��	5,0,265,0q��� -.   $ maxMovementLabel��$
��100%��$��0q�� $	��500��$��5,0,0,5q� � Orientation$ 
Horizontal=�
�������.+��� -/   $ label2��$ ��How to play selected game:��$��28��$	��410��$��0q�� $ Vertical=�$��	10,0,0,10q�.+��� -0   $" selectedGameDescriptionLabel��.���� -1    ��Name$ selectedGameInstructions�� �� TextWrapping$
 Wrap=�$��Select a game from below.��$��60��$	��445���� -2   $ wristGamesGroupBox��$��Wrist extension games��$��Center=�
�������{�.  .��� $��0,10,0,0q�$ Vertical=�$	��230��.+�� $��0,0,0,0q�.+��� -3   $ falconUsageImage2��$	��130��$#��Images/FalconUpDownButton.png��$	��200��$��10,0,0,0q��� -4   $" liftingGamesDescriptionLabel��$	��Top=�$
��Left=�.���� -5   $) #liftingGamesDescriptionInstructions��$
 Wrap=�$p��jMove the Falcon's handle up to jump or lift your character and down to get ready for another jump or lift.��$��50��$	��210���� -6   $ wristGamesGroupBoxList��$��Games��$��Center=�.��� $��0,10,0,0q�.+��� -7   $ imageCrazyRider��$��44��$��Images/Crazy Rider.jpg���� -8   $ buttonCrazyRider��$��Crazy Rider��$	��170��$��40��$��Center=�$	 Click to launch the game���� -9   $ imageLilMads��$��44��$,��&Images/Lil Mads and the Gold Skull.jpg���� -:   $ buttonLilMads��$!��Lil Mads and the Gold Skull��$	��170��$��40��$��Center=�$	 Click to launch the game���� -;   $ imageCoinCollector��$��44��$'��!Images/Botley's Bootles Coins.jpg���� -<   $ buttonCoinCollector��$��Botley's Bootles Coins��$	��170��$��40��$��Center=�$	 Click to launch the game���� -=   $ imageF1��$��44��$��Images/Swooop.png���� ->   $ buttonSwooop��$��Swooop��$	��170��$��40��$��Center=�$	 Click to launch the game���� -?   $ imageSkaterBoy��$��44��$��Images/Skater Boy.jpg���� -@   $ buttonSkaterBoy��$��
Skater Boy��$	��170��$��40��$��Center=�$	 Click to launch the game���� -A   $ imageBMXBoy��$��44��$��Images/BMX Boy.png���� -B   $ buttonBMXBoy��$��BMX Boy��$	��170��$��40��$��Center=�$	 Click to launch the game���� -C   $ imageFunkyKarts��$��44��$��Images/Funky Karts.jpg���� -D   $ buttonFunkyKarts��$��Funky Karts��$	��170��$��40��$��Center=�$	 Click to launch the game���� -E   $ assessmentGroupBox��$��Assessments��
�������$	��220��$��0,20,0,0q�.��� $��Center=�.+��� -F   $ SpeedTestGameLabel��$	��Top=�$
��Left=�
�������.���� $
 Wrap=�$"��Wrist speed assessment game:��$��40��$	��100�� �� 
FontWeight$ Normal"��� -G   $ buttonWristSpeedGame��$��Start��$��80��$��30��$	 Click to launch the game��$��10,0,0,0q��� -H   $ SustainedTestGameLabel��$	��Top=�$
��Left=�
�������.���� $
 Wrap=�$&�� Sustained wrist assessment game:��$��40��$	��100��$ Normal"��� -I   $ buttonSustainWristGame��$��Start��$��80��$��30��$	 Click to launch the game��$��10,0,0,0q��� -J   $  elbowShoulderGamesGroupBox��$��Elbow/shoulder games��$��Center=�
�������$��10,0,0,0q�{�.  .��� $��	0,10,-2,0q�$ Vertical=�$	��Top=�$	��230��.+�� .+��� -K   $ falconUsageImage3��$	��130��$ ��Images/FalconPanButton.png��$	��210��$��Center=�$��10,0,0,0q��� -L   $! movingGamesDescriptionLabel��$	��Top=�$
��Left=�.���� -M   $( "movingGamesDescriptionInstructions��$
 Wrap=�$V��PMove the Falcon's handle Up, Down, Left, Right to move in the desired direction.��$��50��$	��210���� -N   $$ elbowShoulderGamesGroupBoxList��$��Games��$��Center=�.��� $��0,10,0,0q�.+��� -O   $ imageA��$��44��$#��Images/Heroes of the Loot.png���� -P   $ buttonHeroes��$��Heroes of the Loot��$	��170��$��40��$��Center=�$	 Click to launch the game���� -Q   $ imageB��$��44��$��Images/Save the Day.png���� -R   $ buttonSaveTheDay��$��Save the Day��$	��170��$��40��$��Center=�$	 Click to launch the game���� -S   $ imageC��$��44��$��Images/Bird Brawl.png���� -T   $ buttonBirdBrawl��$��
Bird Brawl��$	��170��$��40��$��Center=�$	 Click to launch the game���� -U   $ image4��$��44��$��Images/Pacman.png���� -V   $ buttonPacman��$��Pacman��$	��170��$��40��$��Center=�$	 Click to launch the game���� -W   $ image2��$��44��$"��Images/Looney Tunes Dash.png���� -X   $ buttonLooneyTunes��$��Looney Tunes Dash��$	��170��$��40��$��Center=�$	 Click to launch the game��