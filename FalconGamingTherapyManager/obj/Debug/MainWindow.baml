   M S B A M L   `   `   `  ����U  QFalconGamingTherapyManager, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullG(clr-namespace:FalconGamingTherapyManagerFalconGamingTherapyManager  5   	   +    %FalconGamingTherapyManager.MainWindow   5   	   W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   :local(clr-namespace:FalconGamingTherapyManager     5   	   :xctk)http://schemas.xceed.com/wpf/xaml/toolkit     5   	   -   5          � Title$#  Falcon Gaming-Therapy Manager��5	   	   ���	#FFEAEAEA$
��1000��5   	   $	��680��5   	    � 
ResizeMode$ CanMinimize=�5   	   .��5      ��  �� Orientation$ Vertical=�6   .+�5   
   �� -   5         ��Name$ MainGroupBox��5      $��Patient's Profile��6)   
�������$
��10,5q�6W   .��5      � $��Center=�6   .+�5      �� -   5         ��Name$ profile��5      $��25��6)   $��Images/profile.jpg��65   � 5      $��5,5,0,0q�6   $��Center=�6-   .+�5      �� -   5         ��Name$ 	UserLabel��5      $��User:��6/   $��55��6?   $��25��6J   �� 5      -   5        $ usernameTextBlock��5      $��25��67   $
�� -- ��6C   $	��100��6S   �� 5      -   5        $ SessionLabel��5      $��
Session #:��62   $��65��6G   �� 5      -   5        $ sessionTextBlock��5      $��25��66   $
�� -- ��6B   $	��100��6R   �� 5      -   5         ��Name$ openProfileButton��5      $��Open a profile��68   $��85��6Q   $��30��6\   $��	420,0,0,0q�6�   ���	#FFFFF3C06�   �� 5      -	   5        $ saveProfileButton��5      $��Create profile��68   $��85��6Q   $��30��6\   $��10,0,0,0q�6�   5      5      5       �� 5!   
   -
   5         ��Name$ 
tabControl��5!      $	��580��6X   .@�5"      �� -   5         ��Name$ UserTab��5"      $��Start��6'   $��Center=�66   $	��100��6S   .��5#      �� $ 
Horizontal=�6   $��Center=�66   $	��Top=�6S   $��20,40q�6k   .+�5$      �� $��1��6   $��40(�6(   �� 5%      $	��150��6   $��0,10,0,0q�6(   .��5&      �� 	 �� TextWrapping$
	 Wrap=�6%   $G��AOpen or create a profile using the buttons on top of this window.��69   5'      �� 5(      -   5        $ profileOpenImage��5(      $��Images/exclamation.png��66   $��20��6V   �� 5)      $��2��6   $��40(�6(   $��	100,0,0,0q�66   �� 5*      $	��150��6   $��0,10,0,0q�6)   .��5+      �� $
	 Wrap=�6%   $A��;Use the tabs above to access the therapy activities desired��69   5,      �� 5-      -   5        $ 
step2Image��5-      $��Images/null.png��60   $��20��6I   �� 5.      $��3��6   $��40(�6(   $��	100,0,0,0q�66   �� 5/      $	��150��6   $��0,10,0,0q�6(   .��50      �� $
	 Wrap=�6%   $P��JWhen you are done with a patient/client's session, just close the program.��69   51      52      53      �� 54      -   5        $ WristTab��54      $��Wrist Activities��6(   {�.  $	��150��6T   .��55      �� $ 
Horizontal=�6   .+�56      �� -   5        $ wristSettingsGroupBox��56      $��Wrist Extension Settings��6>   $	��Top=�6`   $	��420��6x   ���	#FFF0F0F0.��57      �� $ Vertical=�6%   $��Center=�6<   .+�58      �� $ 
Horizontal=�6)   .+�59   "   �� -   5        $ weightLabel��59   (   $	��110��6=   $��Falcon's weight:��6I   5:      � 5;      
 � Orientation$
 
Horizontal=�6(   $	��150��6A   .+�5<   "   �� -   5         ��Name$ liftWeightTextBox��5<   *   $��40��6E   $��20��6P   $	��500��6\    �� TextAlignment$ Right=�6g    � ToolTip$- 'Enter a number between 0 and 1000 grams��6}   6�   �� 5=   "   -   5        $ 
gramsLabel��5=   (   $��50��6<   $��grams��6G   �� 5>   "   -   5        $ updateWeightButton��5>   )   $��Update��6E   $��60��6V   $��30��6a   6m   5?      � 5@      $
 
Horizontal=�6(   .+�5A   "   �� -   5        $ label0grams��5A   (   $��30��6=   $	��0 g��6H   $��20,0,0,0q�6V   �� 5B   "   -   5         ��Name$ liftingWeightSlider��5B   )   $	��300��6F    � Maximum$
 1000Q�6u   $��25��6�    � Value$	 500Q�6�    � LargeChange$	 100Q�6�    � SmallChange$ 10Q�6�   ��.  6�   �� 5C   "   -   5        $ label000grams��5C   (   $��50��6?   $��1,000 g��6J   �� 5D   "   -   5        $ easyWeightButton��5D   )   $
��Easy��6C   $��60��6R   $��30��6]   $��80,0,0,0q�6�   �� 5E   "   -   5        $ mediumWeightButton��5E   )   $��Medium��6E   $��60��6V   $��	30,0,30,0q�6a   6t   �� 5F   "   -   5        $ hardWeightButton��5F   )   $
��Hard��6C   $��60��6R   $��5,0,0,0q�6|   5G      �� 5H      $	��370��6(   $��50��64   � 5I      .+�5J   "   �� -   5        $ labelThreshold��5J   (   $��Maximum wrist extension:��6@   $	��210��6c   $��30��6o   $��Center=�6{   �� 5K   "   -   5        $ setWristRangeButton��5K   )   $��Start measure��6F   $��85��6^   $��30��6i   $��20,0,0,0q�6u   ���	#FFFFF3C06�   �� 5L   "   -   5        $ wristRangeReadyImage��5L   (   $��Images/exclamation.png��6F   $��20��6f   $��20,0,0,0q�6q   5M      �� 5N      $ 
Horizontal=�6)   $��Center=�6B   .+�5O   "   �� -   5        $ wristRangeImage��5O   (   $��Images/FalconUpDown.png��6A   $	��100��6b   �� 5P   "   -   5         ��Name$ liftThresholdTextBox��5P   ,   $��0��6J   $��50��6S   $��Center=�6^    �� TextAlignment$ Right=�6y   5Q      �� 5R      $	��370��6(   $��50��64   �� 5S      $ Vertical=�6)   .+�5T   "   � .+�5U   &   �� -   5        $ labelTolerance��5U   ,   $7��1Percentage of maximum extension required to play:��6D   5V   #   � 5W   "   $
 
Horizontal=�6,   $	��100��6E   .+�5X   &   �� -    5        $ liftRequiredTextBox��5X   .   $��30��6K   $��20��6V   $��75��6b   $ Right=�6�   �� 5Y   &   -!   5        $ percentageLabel��5Y   ,   $��20��6E   $��%��6P   �� 5Z   &   -"   5        $ updatePercentageButton��5Z   -   $��Update��6M   $��50��6^   $��30��6i   6u   5[   #   � 5\   "   $
 
Horizontal=�6,   $	��380��6E   .+�5]   &   �� -#   5        $ minWristLabel��5]   ,   $	��50%��6C   $��40��6Q   �� 5^   &   -$   5        $ liftRequiredSlider��5^   -   $	��300��6I   $	 100Q�6x    � Minimum$ 50Q�6�   $��20��6�   $ 75Q�6�   $ 10Q�6�   $ 1Q�6�   ��.  6�   �� 5_   &   -%   5        $ maxWristLabel��5_   ,   $
��100%��6C   $��40��6R   5`   #   5a      �� 5b      $	��370��6(   $��50��64   � 5c      $
 
Horizontal=�6(   $��Center=�6A   $��0,0,0,10q�6^   .+�5d   "   �� -&   5        $ SaveWristSettingsButton��5d   )   $��Save changes��6J   $	��100��6a   $��40��6m   $��30,0,0,0q�6�   �� 5e   "   -'   5        $ saveWristSettingsImage��5e   (   $��Images/null.png��6H   $��25��6a   $
��10,0q�6l   5f      5g      5h      �� 5i      -(   5        $ wristGamesGroupBox��5i      $ ��Wrist extension activities��6;   $��Center=�6_   
�������{�.  $��10,0,0,0q�6�   .��5j      � $
 
Horizontal=�6$   $	��530��6=   $��0,10,0,0q�6I   .+�5k      �� -)   5        $ wristGamesDetailGroupBox��5k   '   $��How to play��6I   $��Center=�6^   .��5l   "   � $��0,20,0,0q�6,   $
 Vertical=�6>   $��Center=�6U   .+�5m   &   �� -*   5        $ falconUsageImage2��5m   ,   $!��Images/WristGamesDetail.JPG��6G   $	��240��6l   �� 5n   &   -+   5        $" liftingGamesDescriptionLabel��5n   ,   $	��240��6R   $	��100��6^   .��5o   *   �� -,   5         ��Name$ wristGamesInstructions��5o   5   $
	 Wrap=�6U   $����For all these games, move the Falcon's handle up to jump or lift the game character and down to get ready for another jump or lift.��6i   5p   '   5q   #   5r      � 5s      $��10,0,0,0q�6(   $
 Vertical=�6:   $	��260��6Q   .+�5w   "   �� --   5        $ wristGamesGroupBoxList��5w   +   $��Games��6K   $��Center=�6Z   .��5x   &   � $��0,10,0,0q�61   .+�5y   *   �� -.   5        $ imageCrazyRider��5y   0   $��44��6I   $��Images/Crazy Rider.jpg��6U   �� 5z   *   -/   5        $ buttonCrazyRider��5z   1   $��Crazy Rider��6K   $	��170��6a   $��40��6m   $��Center=�6y    ^� ShowDuration$ 60000��6�   $� �Goal: 
 to reach the end of the level avoiding obstacles (trees, rocks, birds) and cliffs. 
To play: 
 Press and hold the red button to accelerate, and move the Falcon's handle up and down to jump. 
 
Cilck here to launch (or stop) the game.��6�   �� 5{   *   $��44��60   $��30��6=   $��Images/Button.png��6H   $# This game uses the red button��6c   �� 5|   *   -0   5        $ imageLilMads��5|   0   $��44��6F   $,��&Images/Lil Mads and the Gold Skull.jpg��6R   �� 5}   *   -1   5        $ buttonLilMads��5}   1   $!��Lil Mads and the Gold Skull��6H   $	��170��6n   $��40��6z   $��Center=�6�   $ 60000��6�   $� �Goal: 
 to reach the end of the level avoiding obstacles (boxes) and cliffs. 
To play: 
 Move the Falcon's handle up and down to jump.
 
Click to launch the game��6�   �� 5~   *   -2   5        $ imageCoinCollector��5~   0   $��44��6L   $'��!Images/Botley's Bootles Coins.jpg��6X   �� 5   *   -3   5        $ buttonBootleCasher��5   1   $��Botley's Bootles Coins��6M   $	��170��6n   $��40��6z   $��Center=�6�   $ 60000��6�   $� �Goal: 
 collect as many coins and bootles (bot pets) as possible avoiding the bombs. 
To play: 
 Hold the Falcon's handle up to lift your bot and collect coins or bootles and move the handle down to avoid bombs.

Click to launch the game��6�   �� 5�   *   -4   5        $ imageF1��5�   0   $��44��6A   $��Images/Swooop.png��6M   �� 5�   *   -5   5        $ buttonSwooop��5�   1   $��Swooop��6G   $	��170��6X   $��40��6d   $��Center=�6p   $ 60000��6�   $� �Goal: 
 to keep the plane flying for as long as possible. Catch as many diamonds as possible to refill the plane's fuel and avoid obstacles in the air. 
To play: 
 Move the Falcon's handle up to elevate the plane and move it down to let it fall.

Click to launch the game��6�   �� 5�   *   -6   5        $ imageSkaterBoy��5�   0   $��44��6H   $��Images/Skater Boy.jpg��6T   �� 5�   *   -7   5        $ buttonSkaterBoy��5�   1   $��
Skater Boy��6J   $	��170��6_   $��40��6k   $��Center=�6w   $ 60000��6�   $� �Goal: 
 to reach the end of the level avoiding obstacles and collecting as many trophies and coins as possible. 
To play: 
 Press and hold the red button to accelerate, and move the Falcon's handle up and down to jump.

Click to launch the game��6�   �� 5�   *   $��44��60   $��30��6=   $��Images/Button.png��6H   $# This game uses the red button��6c   �� 5�   *   -8   5        $ imageBMXBoy��5�   0   $��44��6E   $��Images/BMX Boy.png��6Q   �� 5�   *   -9   5        $ buttonBMXBoy��5�   1   $��BMX Boy��6G   $	��170��6Y   $��40��6e   $��Center=�6q   $ 60000��6�   $� �Goal: 
 to reach the end of the level avoiding obstacles and collecting as many trophies and coins as possible. 
To play: 
 Press and hold the red button to accelerate, and move the Falcon's handle up and down to jump.

Click to launch the game��6�   �� 5�   *   $��44��60   $��30��6=   $��Images/Button.png��6H   $# This game uses the red button��6c   �� 5�   *   -:   5        $ imageFunkyKarts��5�   0   $��44��6I   $��Images/Funky Karts.jpg��6U   �� 5�   *   -;   5        $ buttonFunkyKarts��5�   1   $��Funky Karts��6K   $	��170��6a   $��40��6m   $��Center=�6y   $ 60000��6�   $� �Goal: 
 to reach the end of the level collecting as many coins as possible and avoiding falling on spikes and cliffs. 
To play: 
 The kart always accelerates on its own. It can climb walls and the ceiling when it has momentum.
 Move the Falcon's handle up and down to jump off the ground, the walls or the ceiling.

Click to launch the game��6�   �� 5�   *   $��44��60   $��30��6=   $��Images/Button.png��6H   $# This game uses the red button��6c   5�   '   5�   #   �� 5�   "   -<   5        $ assessmentGroupBox��5�   +   $��Assessments��6G   
�������$	��220��6o   $��0,20,0,0q�6{   .��5�   &   � $��Center=�60   .+�5�   *   �� -=   5        $ SpeedTestGameLabel��5�   0   $	��Top=�6L   $
��Left=�6d   
�������.��5�   .   �� $
	 Wrap=�69   $"��Wrist speed assessment game:��6M   $��40��6r   $	��100��6~    �� 
FontWeight$ Normal"�6�   5�   +   �� 5�   *   ->   5        $ buttonWristSpeedGame��5�   1   $��Start��6O   $��80��6_   $��30��6j   $ 60000��6w   $� �Goal: 
 to measure the number of full wrist extensions the player can achieve in 10 seconds. 
To play: 
 Move the Falcon's handle up and down consecutively as many times as possible.

Click to launch the game��6�   $��10,0,0,0q�6�  5�   '   5�   #   5�      5�      5�      5�      5�      �� 5�      -?   5        $ elbowShoulderTab��5�      $��Elbow/Shoulder Activities��60   {�.  $	��150��6e   .��5�      �� $ 
Horizontal=�6   .+�5�      �� -@   5        $# elbowShoulderSettingsGroupBox��5�      $'��!Elbow/shoulder Extension Settings��6F   $	��Top=�6q   $	��420��6�   ���	#FFF0F0F0.��5�      �� $ Vertical=�6%   $��Center=�6<   .+�5�      � .+�5�   "   �� -A   5        $ resistanceLabel��5�   (   $	��110��6A   $��Center=�6M   $��Falcon's resistance:��6h   5�      � 5�      $
 
Horizontal=�6(   $	��150��6A   .+�5�   "   �� -B   5        $ movingResistanceTextBox��5�   *   $��40��6K   $ Right=�6V   $��20��6l   $	��500��6x   6�   �� 5�   "   -C   5        $ resistanceGramsLabel��5�   (   $��50��6F   $��grams��6Q   �� 5�   "   -D   5        $ updateResistanceButton��5�   )   $��Update��6I   $��60��6Z   $��30��6e   6q   5�      � 5�      $
 
Horizontal=�6(   .+�5�   "   �� -E   5        $ label0gramsResistance��5�   (   $��30��6G   $	��0 g��6R   $��20,0,0,0q�6`   �� 5�   "   -F   5        $ moveResistanceSlider��5�   )   $	��300��6G   $
 1000Q�6v   $	 500Q�6�   $ 10Q�6�   $ 1Q�6�   ��.  6�   �� 5�   "   -G   5        $ label000gramsResistance��5�   (   $��50��6I   $��1,000 g��6T   �� 5�   "   -H   5        $ easyResistanceButton��5�   )   $
��Easy��6G   $��60��6V   $��30��6a   $��80,0,0,0q�6�   �� 5�   "   -I   5        $ mediumResistanceButton��5�   )   $��Medium��6I   $��60��6Z   $��30��6e   $��	30,0,30,0q�6q   6�   �� 5�   "   -J   5        $ hardResistanceButton��5�   )   $
��Hard��6G   $��60��6V   $��30��6a   $��5,0,0,0q�6�   5�      �� 5�      $	��370��6(   $��50��64   � 5�      .+�5�   "   �� -K   5        $ labelMoveThreshold��5�   (   $'��!Range of elbow/shoulder movement:��6D   $	��210��6p   $��30��6|   $��Center=�6�   �� 5�   "   -L   5        $ setMoveRangeButton��5�   )   $��Start measure��6E   $��85��6]   $��30��6h   $��20,0,0,0q�6t   ���	#FFFFF3C06�   �� 5�   "   -M   5        $ moveRangeReadyImage��5�   (   $��Images/exclamation.png��6E   $��20��6e   $��20,0,0,0q�6p   5�      � 5�      $	��180��6(   $	��110��64   ��5�   "   �� 5�   &    �� ImageSource$ Images/FalconBG.png��61    j� Stretch$ Uniform=�6S   .+�5�   "   �� -N   5        $ moveThresholdTextBoxUp��5�   ,   $��0��6L   $��60��6U   $��	70,10,0,0q�6`   $ Center=�6s   
�������6�   �� 5�   "   -O   5        $ moveThresholdTextBoxLeft��5�   ,   $��0��6N   $��60��6W   $��	10,20,0,0q�6b   $ Center=�6u   
�������6�   �� 5�   "   -P   5        $ moveThresholdTextBoxRight��5�   ,   $��0��6O   $��60��6X   $��	50,20,0,0q�6c   $ Center=�6v   
�������6�   �� 5�   "   -Q   5        $ moveThresholdTextBoxDown��5�   ,   $��0��6N   $��60��6W   $��	70,20,0,0q�6b   $ Center=�6u   
�������6�   5�      �� 5�      $	��370��6(   $��40��64   � 5�      .+�5�   "   �� -R   5        $ labelTolerancePan��5�   (   $7��1Percentage of maximum extension required to play:��6C   $	��285��6   5�      � 5�      $	��100��6(   .+�5�   "   �� -S   5        $ movementRequiredTextBox��5�   *   $��30��6K   $��20��6V   $��50��6b   $ Right=�6l   {�.  6�   �� 5�   "   -T   5        $% movementRequiredPercentageLabel��5�   (   $��20��6Q   $��%��6\   �� 5�   "   -U   5        $$ updatePercentageMovementButton��5�   )   $��Update��6Q   $��50��6b   $��30��6m   {�.  6�   5�      � 5�      $	��380��6(   .+�5�   "   �� -V   5        $ minMovementLabel��5�   (   $	��50%��6B   $��40��6P   �� 5�   "   -W   5        $ movementRequiredSlider��5�   )   $	��300��6I   $	 100Q�6x   $ 50Q�6�   $��20��6�   $ 50Q�6�   $ 10Q�6�   $ 1Q�6�   ��.  {�.  6�   �� 5�   "   -X   5        $ maxMovementLabel��5�   (   $
��100%��6B   $��40��6Q   5�      �� 5�      $	��370��6(   $��50��64   � 5�      $
 
Horizontal=�6(   $��Center=�6A   $��0,0,0,10q�6^   .+�5�   "   �� -Y   5        $ SaveElbowSettingsButton��5�   )   $	��100��6J   $��40��6V   $��Save changes��6�   $��30,0,0,0q�6�   �� 5�   "   -Z   5        $ saveElbowSettingsImage��5�   (   $��Images/null.png��6H   $��25��6a   $
��10,0q�6l   5�      5�      5�      �� 5�      -[   5        $  elbowShoulderGamesGroupBox��5�      $��Elbow/shoulder activities��6C   $��Center=�6f   
�������$��10,0,0,0q�6�   {�.  .��5�      � $
 
Horizontal=�6$   $	��540��6=   $��0,10,0,0q�6J   .+�5�      �� -\   5        $ elbowGamesDetailGroupBox��5�   '   $��How to play��6I   $��Center=�6^   .��5�   "   � $��0,20,0,0q�6,   $
 Vertical=�6>   .+�5�   &   �� -]   5        $ falconUsageImage3��5�   ,   $$��Images/ElbowFalconExercise.jpg��6G   $	��240��6o   �� 5�   &   -^   5        $! movingGamesDescriptionLabel��5�   ,   $	��Top=�6Q   $	��240��6i   $	��100��6u   .��5�   *   �� -_   5        $ elbowGamesInstructions��5�   5   $
	 Wrap=�6U   $k��eFor all these games, move the Falcon's handle Up, Down, Left, Right to move in the desired direction.��6i   5�   '   5�   #   5�      � 5�      $��10,0,0,0q�6(   $
 Vertical=�6:   $	��Top=�6Q   $	��260��6i   .+�5�   "   �� -`   5        $$ elbowShoulderGamesGroupBoxList��5�   +   $��Games��6S   $��Center=�6b   .��5�   &   � $��0,10,0,0q�61   .+�5�   *   �� -a   5        $ imageA��5�   0   $��44��6@   $#��Images/Heroes of the Loot.png��6L   �� 5�   *   -b   5        $ buttonHeroes��5�   1   $��Heroes of the Loot��6G   $	��170��6d   $��40��6p   $��Center=�6|   $ 60000��6�   $� �Goal: 
 to navigate a dungeon collecting as many treasures as possible while keeping monsters at bay.
 Some doors in the dungeon require a key that can be found in other rooms of the dungeon. 
To play: 
 Move the Falcon's handle up, down, left or right to navigate the dungeon with the character.
 And press and hold the red button to attack surrounding monsters without a need to aim at them.

Click to launch the game��6�   �� 5�   *   $��44��60   $��30��6=   $��Images/Button.png��6H   $# This game uses the red button��6c   �� 5�   *   -c   5        $ imageB��5�   0   $��44��6@   $��Images/Save the Day.png��6L   �� 5�   *   -d   5        $ buttonSaveTheDay��5�   1   $��Save the Day��6K   $	��170��6b   $��40��6n   $��Center=�6z   $ 60000��6�   $� �Goal: 
 to save as many people from the disaster zone as possible. 
To play: 
 Move the Falcon's handle up, down, left or right to move the helicopter in the desired direction.
 Touch the characters calling for help with the helicopter to rescue them. 
 Once you have loaded 10 passengers, unload them in one of the safe platforms.
 Position the helicopter in front of a fire and press and hold the red button to throw water and turn it off.

Click to launch the game��6�   �� 5�   *   $��44��60   $��30��6=   $��Images/Button.png��6H   $# This game uses the red button��6c   �� 5�   *   -e   5        $ imageC��5�   0   $��44��6@   $��Images/Bird Brawl.png��6L   �� 5�   *   -f   5        $ buttonBirdBrawl��5�   1   $��
Bird Brawl��6J   $	��170��6_   $��40��6k   $��Center=�6w   $ 60000��6�   $� �Goal: 
 to gather as many eggs as possible. 
To play: 
 Move the Falcon's handle up, down, left or right to move the character in the desired direction.
Press and hold the red button to attack enemies in front of the character and find hidden eggs.

Click to launch the game��6�   �� 5�   *   $��44��60   $��30��6=   $��Images/Button.png��6H   $# This game uses the red button��6c   �� 5�   *   -g   5        $ image4��5�   0   $��44��6@   $��Images/Pacman.png��6L   �� 5�   *   -h   5        $ buttonPacman��5�   1   $��Pacman��6G   $	��170��6X   $��40��6d   $��Center=�6p   $ 60000��6�   $� �Goal: 
 to clear up as many levels as possible. 
To play: 
 Move the Falcon's handle up, down, left or right to move the character in the desired direction,
running away from the ghosts and eating all the dots in the level.
 Eat the big dots to make the ghost edible for a short time.

Click to launch the game��6�   �� 5�   *   -i   5        $ image2��5�   0   $��44��6@   $"��Images/Looney Tunes Dash.png��6L   �� 5�   *   -j   5        $ buttonLooneyTunes��5�   1   $��Looney Tunes Dash��6L   $	��170��6h   $��40��6t   $��Center=�6�   $ 60000��6�   $� �Goal: 
 to escape from Angry Sam and get home avoiding obstacles in the track. 
 To play: 
 Move the Falcon's handle left or right to change lanes, up to jump a hole or an obstacle, and down to slide down and avoid being hit on the head.

Click to launch the game��6�   6�  5�   '   5�   #   5�      5�      5�      5�      5�      5�      5�      5�      