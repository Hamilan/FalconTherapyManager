   M S B A M L   `   `   `  ����Q  MFalconGamingTherapyManager, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null?$clr-namespace:FalconGamingTherapyManagerFalconGamingTherapyManager  5   	   +    %FalconGamingTherapyManager.NewMainWindow2   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   6local$clr-namespace:FalconGamingTherapyManager     5   	   :xctk)http://schemas.xceed.com/wpf/xaml/toolkit     5   	   -   5          � Title$#  Falcon Gaming-Therapy Manager��5	   	   $��860.950��6/   ���	#FFEAEAEA$��768.75��5   &   .��5      �� $
��Left=�6   $	��Top=�6,    �� Orientation$ 
Horizontal=�6D   $	��850��6]   .+�5   
   � $	��355��6   .+�5      �� -   5         ��Name$ MainGroupBox��5      $��Patient's Profile��6-   $	��Top=�6H   $
��Bold"�6`   $��0q�6r   
�������.��5      � $
��20,0q�6   $	��Top=�6*   .+�5      �� -   5         ��Name$ profile��5      $��60��6-   $��Images/profile.jpg��69   � 5      $��5,10,0,0q�6    $	��Top=�62   $	��148��6J   .+�5      �� -   5         ��Name$ 	UserLabel��5       $��User:��63   $��77��6C   $��Normal"�6N   �� 5      -   5         ��Name$ usernameTextBlock��5   "   $��22��6=    �� TextWrapping$
 Wrap=�6I   $��Default��6]   $��Normal"�6l   $	��140��6�   $��5,0,0,0q�6�   5      � 5      $��5,10,0,0q�6    $	��Top=�62   $��85��6J   .+�5      �� -   5         ��Name$ saveProfileButton��5   !   $��Create profile��6<   $��85��6U   $��30��6`   $��Normal"�6l   6�   �� 5      -   5        $ openProfileButton��5   !   $��Open profile��6<   $��85��6S   $��30��6^   $	��0,5q�6j   $��Normal"�6w   6�   5      5      5      �� 5      -   5        $ settingsGroupBox��5      $��Profile settings��61   $	��Top=�6K   $
��Bold"�6c   
�������{�.  .��5       � $��Center=�6   .+�5!      �� -	   5        $$ wristExtensionSettingsGroupBox��5!      $��Wrist Extension��6G   $	��Top=�6`   $��Normal"�6x   .��5"      � $��Center=�6$   .+�5#      	� -
   5         	�Name$! radioButtonLiftFalconOption��5#   *   $��Falcon's weight:��6O   $	��120��6j   $��30��6v   $
��10,0q�6�   $��Center=�6�   	 	� 	GroupName$
	 Game��6�   
 � ToolTip$1
 +Click to allow changing the Falcon's weight��6�   �� 5$      -   5        $ liftWeightTextBox��5$   $   $��90��6?   $��	500 grams��6J   �� 5%      -   5         ��Name$ liftingWeightSlider��5%   %   $	��300��6B    � Maximum$
 1000Q�6q   $��25��6�   $
��10,0q�6�    � Value$	 500Q�6�    � LargeChange$	 100Q�6�    � SmallChange$ 10Q�6�   {�.  ��.  6�   �� 5&      -   5        $ easyWeightButton��5&   %   $
��Easy��6?   $��60��6N   $��30��6Y   $��	30,0,10,0q�6�   {�.  6�   �� 5'      -   5        $ mediumWeightButton��5'   %   $��Medium��6A   $��60��6R   $��	30,0,30,0q�6]   {�.  6�   �� 5(      -   5        $ hardWeightButton��5(   %   $
��Hard��6?   $��60��6N   $��15,0,0,0q�6x   {�.  6�   �� 5*      $	��290��6(   $
��20,0q�64   $��20��6B   �� 5,      -   5        $ labelThreshold��5,   $   $��Maximum wrist extension:��6<   $	��150��6_   $��30��6k   $��Center=�6w   �� 5-      -   5         ��Name$ liftThresholdTextBox��5-   (   $��0��6F   $��60��6O   $��Center=�6Z    �� TextAlignment$ Right=�6u   �� 5.      -   5        $ setWristRangeButton��5.   %   $��Start measure��6B   $��85��6Z   $��30��6e   $��10,0,0,0q�6q   $��Center=�6�   6�   �� 5/      -   5        $ labelTolerance��5/   $   $7��1Percentage of maximum extension required to play:��6<   $	��285��6x   �� 50      -   5        $ liftingRequiredLabel��50   $   $��40��6B   $
��100%��6M   �� 51      -   5        $ liftingRequiredSlider��51   %   $	��300��6D   $	 100Q�6s    � Minimum$ 50Q�6�   $��20��6�   $
��10,0q�6�   $ 90Q�6�   $ 10Q�6�   $ 1Q�6�   ��.  6�   �� 52      -   5        $ minWristLabel��52   $   $	��50%��6;   $��0q�6I   $��	5,0,265,0q�6U   �� 53      -   5        $ maxWristLabel��53   $   $
��100%��6;   $��0q�6J   54      55      �� 56      -   5        $# elbowShoulderSettingsGroupBox��56      $��Elbow/shoulder Extension��6F   $	��Top=�6h   $��Normal"�6�   .��57      � $��Center=�6$   .+�58      	� -   5        $  radioButtonPanFalconOption��58   *   $��Falcon's resistance:��6N   $	��120��6m   $��30��6y   $
��10,0q�6�   $��Center=�6�   $
	 Game��6�   $5
 /Click to allow changing the Falcon's resistance��6�   �� 59      -   5        $ movingResistanceLabel��59   $   $��90��6C   $��Center=�6N   $��	500 grams��6i   �� 5:      -   5        $ moveResistanceSlider��5:   %   $	��300��6C   $
 1000Q�6r   $��30��6�   $
��10,0q�6�   $	 500Q�6�   $ 10Q�6�   $ 1Q�6�   {�.  ��.  6�   �� 5;      -   5        $ easyResistanceButton��5;   %   $
��Easy��6C   $��60��6R   $��25��6]   $��	30,0,10,0q�6�   {�.  6�   �� 5<      -   5        $ mediumResistanceButton��5<   %   $��Medium��6E   $��60��6V   $��	30,0,30,0q�6a   {�.  6�   �� 5=      -   5        $ hardResistanceButton��5=   %   $
��Hard��6C   $��60��6R   $��15,0,0,0q�6�   {�.  6�   �� 5?      $	��290��6(   $
��20,0q�64   $��20��6B   �� 5A      -   5        $ labelMoveThreshold��5A   $   $'��!Range of elbow/shoulder movement:��6@   $	��210��6l   $��30��6x   $��Center=�6�   �� 5B      -    5        $ setMoveRangeButton��5B   %   $��Start measure��6A   $��85��6Y   $��30��6d   $��8,0,0,0q�6p   $��Center=�6�   6�   � 5C      $��70,0,0,0q�6(   $��Center=�6:   $	��180��6W   $	��110��6c   ��5D   "   �� 5E   &    �� ImageSource$ Images/FalconBG.png��61    j� Stretch$ Uniform=�6S   .+�5G   "   �� -!   5        $ moveThresholdTextBoxUp��5G   ,   $��0��6L   $��60��6U   $��	70,10,0,0q�6`   $ Center=�6s   
�������6�   �� 5H   "   -"   5        $ moveThresholdTextBoxLeft��5H   ,   $��0��6N   $��60��6W   $��	10,20,0,0q�6b   $ Center=�6u   
�������6�   �� 5I   "   -#   5        $ moveThresholdTextBoxRight��5I   ,   $��0��6O   $��60��6X   $��	50,20,0,0q�6c   $ Center=�6v   
�������6�   �� 5J   "   -$   5        $ moveThresholdTextBoxDown��5J   ,   $��0��6N   $��60��6W   $��	70,20,0,0q�6b   $ Center=�6u   
�������6�   5K      �� 5L      -%   5        $ labelTolerancePan��5L   $   $7��1Percentage of maximum extension required to play:��6?   $	��285��6{   �� 5M      -&   5        $ movementRequiredLabel��5M   $   $��40��6C   $
��100%��6N   �� 5N      -'   5        $ movementRequiredSlider��5N   %   $	��300��6E   $	 100Q�6t   $ 50Q�6�   $��20��6�   $
��10,0q�6�   $ 90Q�6�   $ 10Q�6�   $ 1Q�6�   ��.  6�   �� 5O      -(   5        $ minMovementLabel��5O   $   $	��50%��6>   $��0q�6L   $��	5,0,265,0q�6X   �� 5P      -)   5        $ maxMovementLabel��5P   $   $
��100%��6>   $��0q�6M   5Q      5R      	� 5S      -*   5        $" radioButtonTurnOffResistance��5S   "   $ ��Turn off resistance/weight��6H   $	��175��6m   $��30��6y   $��Center=�6�   $
	 Game��6�    d� 	IsChecked$
 TrueY�6�   $
��15,5q�6�   {�.  $��Normal"�6  5U      5V      5W      � 5X   
   $	��490��6   $��5,0,0,0q�6    .+�5Y      �� -+   5        $ gamesGroupBox��5Y      $��Games��6.   $��Center=�6=   $
��Bold"�6Z   
�������{�.  $	��485��6�   .��5Z      �  � Orientation$ 
Horizontal=�6   .+�5[      �� -,   5        $ label2��5[      $��How to play:��6,   $��28��6C   $	��410��6O   $��0q�6[   �� 5\      --   5        $ falconUsageImage��5\      $	��130��66   $��Images/SelectAGame.png��6C   $	��200��6c   $��Center=�6o   $��0,0,0,5q�6�   � 5]      $ Vertical=�6    .+�5^      �� -.   5        $" selectedGameDescriptionLabel��5^       $��80��6F   $	��Top=�6R   $
��Left=�6j   .��5_      �� -/   5         ��Name$ selectedGameInstructions��5_   )    �� TextWrapping$
 Wrap=�6K   $/��)Select a game style or a game from below.��6_    �� 
FontWeight$ Normal"�6�   $��80��6�   $	��220��6�   5`      5a      �� 5b      -0   5        $ liftGamesGroupBox��5b      $��Wrist extension games��6:   $��Center=�6Y   $
��Bold"�6v   
�������$-
 'Click to active lift/up-down games mode��6�   .��5c      � $��	0,10,-2,2q�6$   $ Vertical=�67   $	��220��6N   .+�5d      � $��0,0,0,0q�6)   .+�5e   "   �� -1   5        $ falconUsageImage2��5e   (   $	��130��6C   $#��Images/FalconUpDownButton.png��6P   $	��200��6w   $��10,0,0,0q�6�   �� 5f   "   -2   5        $ ChromeGamesLabel��5f   (   $��Games��6B   $	��215��6R   $��Bottom=�6^   $
��Left=�6�   
�������6�   �� 5g   "   -3   5        $ imageCrazyRider��5g   (   $��44��6A   $��Images/CrazyRiderIcon.jpg��6M   �� 5h   "   -4   5        $ buttonCrazyRider��5h   )   $��Crazy Rider��6C   $	��170��6Y   $��40��6e   $��Center=�6q   $
 Click to launch the game��6�   �� 5i   "   -5   5        $ imageFunkyKarts��5i   (   $��44��6A   $��Images/FunkyKarts.jpg��6M   �� 5j   "   -6   5        $ buttonFunkyKarts��5j   )   $��Funky Karts��6C   $	��170��6Y   $��40��6e   $��Center=�6q   $
 Click to launch the game��6�   �� 5k   "   -7   5        $ image1��5k   (   $��44��68   $+��%Images/LilMadsAndTheGoldSkullIcon.jpg��6D   �� 5l   "   -8   5        $ buttonLilMads��5l   )   $!��Lil Mads and the Gold Skull��6@   $	��170��6f   $��40��6r   $��Center=�6~   $
 Click to launch the game��6�   �� 5m   "   -9   5        $ imageF1��5m   (   $��44��69   $��Images/Swoop.png��6E   �� 5n   "   -:   5        $ buttonSwoop��5n   )   $��Swoop��6>   $	��170��6N   $��40��6Z   $��Center=�6f   $
 Click to launch the game��6�   5o      5p      5q      �� 5r      -;   5        $ moveAroundGamesGroupBox��5r      $��Shoulder/elbow/grip games��6@   $��Center=�6c   $
��Bold"�6�   
�������$,
 &Click to active move-around games mode��6�   $��10,0,0,0q�6  .��5s      � $��	0,10,-2,0q�6$   $ Vertical=�67   $	��Top=�6N   $	��220��6f   .+�5t      � .+�5u   "   �� -<   5        $ falconUsageImage3��5u   (   $	��130��6C   $ ��Images/FalconPanButton.png��6P   $	��200��6t   $��Center=�6�   $��10,0,0,0q�6�   �� 5v   "   -=   5        $ ChromeGamesLabel2��5v   (   $��Games��6C   $	��215��6S   $��Bottom=�6_   $
��Left=�6�   
�������6�   �� 5w   "   ->   5        $ imageA��5w   (   $��44��68   $ ��Images/HeroesOfTheLoot.png��6D   �� 5x   "   -?   5        $ buttonHeroes��5x   )   $��Heroes of the Loot��6?   $	��170��6\   $��40��6h   $��Center=�6t   $
 Click to launch the game��6�   �� 5y   "   -@   5        $ imageB��5y   (   $��44��68   $��Images/SaveTheDay.png��6D   �� 5z   "   -A   5        $ buttonSaveTheDay��5z   )   $��Save the Day��6C   $	��170��6Z   $��40��6f   $��Center=�6r   $
 Click to launch the game��6�   �� 5{   "   -B   5        $ imageC��5{   (   $��44��68   $��Images/BirdBrawl2.png��6D   �� 5|   "   -C   5        $ buttonBirdBrawl��5|   )   $��
Bird Brawl��6B   $	��170��6W   $��40��6c   $��Center=�6o   $
 Click to launch the game��6�   �� 5   "   -D   5        $ image4��5   (   $��44��68   $��Images/PacMan.png��6D   �� 5�   "   -E   5        $ buttonPacman��5�   )   $��Pacman��6?   $	��170��6P   $��40��6\   $��Center=�6h   $
 Click to launch the game��6�   �� 5�   "   -F   5        $ image2��5�   (   $��44��68   $ ��Images/LooneyTunesDash.png��6D   �� 5�   "   -G   5        $ buttonLooneyTunes��5�   )   $��Looney Tunes Dash��6D   $	��170��6`   $��40��6l   $��Center=�6x   $
 Click to launch the game��6�   6�   5�      5�      5�      5�      5�      �� 5�      -H   5        $ assessmentGroupBox��5�      $��Assessments��63   $
��Bold"�6H   
�������$	��300��6m   {�.  .��5�      � $��Center=�6   .+�5�      �� -I   5        $ TestGameLabel��5�      $"��Wrist speed assessment Game:��63   $	��180��6Z   $��Bottom=�6f   $
��Left=�6�   
�������$��Normal"�6�   �� 5�      -J   5        $ buttonAssessmentGame��5�      $��Start��6;   $��80��6K   $��30��6V   $��Normal"�6b   $
 Click to launch the game��6v   6�   �� 5�      $	��200��6    $��25��6,   $
��30,0q�68   �� 5�      -K   5        $ openReportButton��5�      $��See patient's progress��67   $	��135��6X   $��30��6d   $��Normal"�6p   $7
 1Click to open a summary of the patient's progress��6�   $��60,0,0,5q�6�   6�   5�      5�      5�      5�      5�      