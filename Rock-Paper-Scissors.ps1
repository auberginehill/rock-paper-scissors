<#
Rock-Paper-Scissors.ps1
#>


[CmdletBinding()]
Param (
    [Parameter(ValueFromPipeline=$true,
    ValueFromPipelineByPropertyName=$true,
      HelpMessage='Would you like to play an ancient game or a game from the eastern cultural sphere? Please add -Roman to play "Micare Digitis" or -Chinese to play "Shoushiling" or -Japanese for a round of "Mushi-ken". To see the the rules of a game, a parameter -Help may be added.')]
    [Alias("Wait","Pause")]
    [ValidateRange(0,10000000000)]
	[int]$Delay = "3030", # in milliseconds
    [switch]$Chinese,
    [switch]$Japanese,
    [switch]$Roman,
    [Alias("Text","Definition","Rules")]
    [switch]$Help,
    [switch]$Audio
)


Begin {


    # Use Get-Random to create a random array of one object plus define some other common variables (doesn't include random for Micare Digitis)
    $delay_notify_threshold = 15000 # in milliseconds (1 minute = 60000 milliseconds)
    $random_1d3 = Get-Random -Count 1 -InputObject (1..3)
    $empty_line = ""


    $definition_rock_paper_scissors = "In 'Rock-paper-scissors' (or 'Stone-paper-scissors') each participant shows one of the three hand signals after a synchronized countdown, which consists of two or three pre-steps (i.e. 3-2-1-signal or 2-1-signal), has elapsed. It is essential for the flow of the game for all participants (1) to know the number of pre-steps, for them to be certain, will the signal be released on third or fourth count and (2) then to be in the same rhythm before the handsigns are signalled. If at any time the players are not in synch with their pre-steps (primes), it is recommended to restart the game, since having players deliver their throw at the same time is critical in ensuring a fair match. For fairness of the play, it is recommended to agree on the number of rounds to be played before the playing begins, so that each participant will know whether the outcome will be decided in one go or whether the game is in a tournament mode (best out of [uneven_number_of_rounds]). The released hand signs each have an inherent value in which one sign will always be better than the released hand sign and another hand sign will be worse than the released hand sign - furthermore it is ordained that all the signs together are valued successively so that they form an 'Infinite Loop of Betterness'. In 'Rock-paper-scissors' this loop is formed by valuing the hand signals as follows: 'Rock wins against Scissors, Scissors wins against Paper and Paper wins against Rock' or in a negative tone: 'Rock loses against Paper, Paper loses against Scissors and Scissors loses against Rock'. In 'Rock-paper-scissors' ties, where the participants show the same hand signal as a result, per se, cannot be broken, but the occured 'Tie-Break Situation' is usually resolved by playing another round of 'Rock-paper-scissors' immediately after the existence of 'Tie-Break Situation' has been confirmed."

    $help_text_rock_paper_scissors = "In 'Rock-paper-scissors' it is customary to use the closed fist when signalling the 'Rock' (where the wrist is positioned similarly as to holding a glass full of water (and the fingers are closed together) with the thumb resting about at the same height as the topmost finger of the hand. The thumb is usually not concealed by the fingers), the open horizontal flat hand palm facing down when signalling the 'Paper' (which is delivered in the same manner as rock with the exception that all fingers including the thumb are fully extended and horizontal with the points of the fingers facing the opposing player) and a fist with the index and middle fingers forming a vertical V when signalling the 'Scissors' (which is delivered in the same manner as rock with the exception that the index and middle fingers are fully extended toward the opposing player. It is considered good form to angle the topmost finger upwards and the lower finger downwards in order to create a roughly 30-45 degree angle between the two digits and thus mimic a pair of scissors). Source: http://worldrps.com/game-basics/"




    # Shoushiling (Shoushìlìng: traditional Chinese: 手勢令; literally: 'hand command')
    $definition_shoushiling = "In 'Shoushiling' (literally: 'hand command') each participant shows one of the three hand signals after a synchronized countdown, which consists of one to three pre-steps (i.e. 1-signal to 3-2-1-signal), has elapsed. It is essential for the flow of the game for all participants (1) to know the number of pre-steps, for them to be certain, on which count the signal shall be released and (2) then to be in the same rhythm before the handsigns are signalled. If at any time the players are not in synch with their pre-steps (primes), it is recommended to restart the game, since having players deliver their throw at the same time is critical in ensuring a fair match. For fairness of the play, it is recommended to agree on the number of rounds to be played before the playing begins, so that each participant will know whether the outcome will be decided in one go or whether the game is in a tournament mode (best out of [uneven_number_of_rounds]). The released hand signs each have an inherent value in which one sign will always be better than the released hand sign and another hand sign will be worse than the released hand sign - furthermore it is ordained that all the signs together are valued successively so that they form an 'Infinite Loop of Betterness'. In 'Shoushiling' this loop is formed by valuing the hand signals as follows: 'Centipede (wu) wins against Snake (she), Snake (she) wins against Frog (wa) and Frog (wa) wins against Centipede (wu)' or in a negative tone: 'Centipede (wu) loses against Frog (wa), Frog (wa) loses against Snake (she) and Snake (she) loses against Centipede (wu)'. In 'Shoushiling' ties, where the participants show the same hand signal as a result, per se, cannot be broken, but the occured 'Tie-Break Situation' is usually resolved by playing another round of 'Shoushiling' immediately after the existence of 'Tie-Break Situation' has been confirmed."

    $help_text_shoushiling = "In 'Shoushiling' the signal code language differs from its Western counterparts, and in 'Shoushiling' it is customary to use the little (pinky) finger when signalling the 'Centipede'(wu), the index finger when signalling the 'Snake' (she) and the thumb when signalling the 'Frog' (wa). Source: http://www.historyofemotions.org.au/media/230620/2015-zest-education-pack-final-web-version.pdf & Linhart, Sepp (1995). 'Some Thoughts on the Ken Game in Japan: From the Viewpoint of Comparative Civilization Studies. Senri Ethnological Studies 40: 101-124. http://tinyurl.com/zju37c2"




    # Mushi-ken (虫拳) (one of the games of 'sansukumi-ken' (三竦み拳) - Japanese
    $definition_mushi_ken = "In 'Mushi-ken' (ken ('fist') of the small animals, one of the games of 'sansukumi-ken' (ken ('fist') of the three who are afraid of one another)) each participant shows one of the three hand signals after a synchronized countdown, which consists of one to three pre-steps (i.e. 1-signal to 3-2-1-signal), has elapsed. It is essential for the flow of the game for all participants (1) to know the number of pre-steps, for them to be certain, on which count the signal shall be released and (2) then to be in the same rhythm before the handsigns are signalled. If at any time the players are not in synch with their pre-steps (primes), it is recommended to restart the game, since having players deliver their throw at the same time is critical in ensuring a fair match. For fairness of the play, it is recommended to agree on the number of rounds to be played before the playing begins, so that each participant will know whether the outcome will be decided in one go or whether the game is in a tournament mode (best out of [uneven_number_of_rounds]). The released hand signs each have an inherent value in which one sign will always be better than the released hand sign and another hand sign will be worse than the released hand sign - furthermore it is ordained that all the signs together are valued successively so that they form an 'Infinite Loop of Betterness'. In 'Mushi-ken' this loop is formed by valuing the hand signals as follows: 'Slug (namekuji / namekujiri, a shell-less 'snail') wins against Snake (hebi), Snake (hebi) wins against Frog (kawazu) and Frog (kawazu) wins against Slug (namekuji)' or in a negative tone: 'Slug (namekuji) loses against Frog (kawazu), Frog (kawazu) loses against Snake (hebi) and Snake (hebi) loses against Slug (namekuji)'. In 'Mushi-ken' ties, where the participants show the same hand signal as a result, per se, cannot be broken, but the occured 'Tie-Break Situation' is usually resolved by playing another round of 'Mushi-ken' immediately after the existence of 'Tie-Break Situation' has been confirmed."

    $help_text_mushi_ken = "In 'Mushi-ken' the signal code language differs from its Western counterparts, and in 'Mushi-ken' it is customary to use the little (pinky) finger when signalling the 'Slug' (namekuji), the index finger when signalling the 'Snake' (hebi) and the thumb when signalling the 'Frog' (kawazu (modern: kaeru)). Movements are performed very quickly, and the game is usually played until three or five wins. The game is customarily played only with right hand while the left hand was used to count the wins. The participants could also follow the alternated ritus of Jan-ken Style, where both participants start by saying 'Saisho (wa) guu' (Starting with a rock), and after holding out a closed fist raise their primary hand slightly, and follow it with 'janken pon!' simultaneously throwing out their move, whether it's a slug, snake or frog. If there's a tie (a draw or 'aiko', if both participants chose the same move), they say 'Aiko desho!' (It seems like a tie!) and repeat the ritual 'Saisho guu, janken pon' in an almost trance-like rapid-fire succession until one player (finally) wins. Source: https://japandaily.jp/decision-making-powers-janken-2626/ & Linhart, Sepp, and Sabine Frühstück: 'The Culture of Japan as Seen through Its Leisure': https://books.google.com/books?id=k_Cb7a6FQwwC&pg=PA325"




    # Micare Digitis (Flashing of Fingers) - Roman
    $definition_micare_digitis = "In 'Micare Digitis' (Flashing of Fingers) each participant shows zero to five fingers after a synchronized countdown, which consists of one to three pre-steps (i.e. 1-signal to 3-2-1-signal), has elapsed. It is essential for the flow of the game for all participants (1) to know the number of pre-steps, for them to be certain, on which count the finger(s) shall be shown and (2) then to be in the same rhythm before the handsign is signalled. If at any time the players are not in synch with their pre-steps (primes), it is recommended to restart the game, since having players deliver their throw at the same time is critical in ensuring a fair match. For fairness of the play, it is recommended to agree before the playing begins on the number of rounds a participant must guess correctly (or points achieve) in order to win the match ('Micare Digitis' is usually played in a tournament-mode). In 'Micare Digitis' at the same time when a hand sign is signalled also a number, which should represent the participants guess of the total number of fingers shown on the current round, is pronounced (usually a number ranging from zero to ten is uttered). This guess is validated correct or false by the total number of fingers that can be seen. In 'Micare Digitis' ties (draws), where the participants pronounce the same number as a result that is validated as correct, per se, cannot be broken, but the occured 'Tie-Break Situation' is usually resolved by playing another round of 'Micare Digitis' immediately after the existence of 'Tie-Break Situation' has been confirmed. After each round, however, the fingers are counted to see, if anyone guessed the total number of fingers correctly. If one of the participants guessed correctly, that person wins the round, and one point is awarded to that (lucky) player. If no one guessed the right number then nobody wins that round, and no points are awarded for that round. If all participants guessed the correct answer, then it is a draw ('Tie-Break Situation') and nobody gets credit for winning the round, and no points are awarded for that round. The play continues until one of the participants reaches the number of rounds won (or points) needed to win the match."

    $help_text_micare_digitis = "In 'Micare Digitis' the hand-signs are signalled with a primary hand (by extending the fingers, if any), while the secondary hand is kept out of sight, usually behind one's back. The secondary hand is usually used to count the current personal score (i.e. the number of rounds won). In 'Micare Digitis', when signalling the number three, it might be customary to use a similar hand sign to what is seen some of the NBA referees using while indicating a three-point-shot-attempt, where index finger is curved beside the thumb while the last three digits remain straight. When signalling the 'Zero' or 'no fingers' in 'Micare Digitis', the extended hand is accompanied with a closed fist in a similar fashion to the 'Rock' in 'Rock-paper-scissors'. Source: http://www.appalachianhistory.net/2011/09/only-play-this-game-with-honest-man.html & Rich, Anthony (1893):'A Dictionary of Roman and Greek Antiquities', page 422-423: http://www.archive.org/stream/adictionaryroma00richgoog#page/n429/mode/2up"




    # Function used to convert numerical wait times to text
    function Get-TimeDifference {
        param ($wait_time)

        If ($wait_time.Days -ge 2) {
            $time_text = [string]$wait_time.Days + ' days ' + $wait_time.Hours + ' h ' + $wait_time.Minutes + ' min'
        } ElseIf ($wait_time.Days -gt 0) {
            $time_text = [string]$wait_time.Days + ' day ' + $wait_time.Hours + ' h ' + $wait_time.Minutes + ' min'
        } ElseIf ($wait_time.Hours -gt 0) {
            $time_text = [string]$wait_time.Hours + ' h ' + $wait_time.Minutes + ' min'
        } ElseIf ($wait_time.Minutes -gt 0) {
            $time_text = [string]$wait_time.Minutes + ' min ' + $wait_time.Seconds + ' sec'
        } ElseIf ($wait_time.Seconds -gt 0) {
            $time_text = [string]$wait_time.Seconds + ' sec'
        } Else {
            $time_text = [string]''
        } # else (if)

            If ($time_text.Contains(" 0 h")) {
                $time_text = $time_text.Replace(" 0 h"," ")
                } If ($time_text.Contains(" 0 min")) {
                    $time_text = $time_text.Replace(" 0 min"," ")
                    } If ($time_text.Contains(" 0 sec")) {
                    $time_text = $time_text.Replace(" 0 sec"," ")
            } # if ($time_text: first)

    $time_text

    } # function


} # begin




Process {


    If ((-not $Chinese) -and (-not $Japanese) -and (-not $Roman)) {

        # Classic 'Rock-paper-scissors'
        $header = "Rock-paper-scissors"
        $coline = "-------------------"
        $definition = $definition_rock_paper_scissors
        $help_text = $help_text_rock_paper_scissors

        If ($random_1d3 -eq 1) { $result = "Rock" } ElseIf ($random_1d3 -eq 2) { $result = "Paper" } ElseIf ($random_1d3 -eq 3) { $result = "Scissors" } Else { Write-Verbose "Dynamite" -verbose

        Write-Verbose "The Myth of Dynamite Exposed" } # http://worldrps.com/the-myth-of-dynamite-exposed/


    } ElseIf ((-not $Chinese) -and ($Japanese) -and (-not $Roman)) {

        # Mushi-ken (虫拳) - Japanese
        $header = "Mushi-ken"
        $coline = "---------"
        $definition = $definition_mushi_ken
        $help_text = $help_text_mushi_ken

        If ($random_1d3 -eq 1) { $result = "Slug (namekuji)" } ElseIf ($random_1d3 -eq 2) { $result = "Snake (hebi)" } ElseIf ($random_1d3 -eq 3) { $result = "Frog (kawazu)" } Else { Write-Verbose "The Dragon (ryuu)" -verbose }


    } ElseIf (($Chinese) -and (-not $Japanese) -and (-not $Roman)) {

        # Shoushiling (手勢令) - Chinese
        $header = "Shoushiling"
        $coline = "-----------"
        $definition = $definition_shoushiling
        $help_text = $help_text_shoushiling

        If ($random_1d3 -eq 1) { $result = "Centipede (wu)" } ElseIf ($random_1d3 -eq 2) { $result = "Snake (she)" } ElseIf ($random_1d3 -eq 3) { $result = "Frog (wa)" } Else { Write-Verbose "The Dragon (long)" -verbose }


    } ElseIf ((-not $Chinese) -and (-not $Japanese) -and ($Roman)) {

        # Micare Digitis (Flashing of Fingers) - Roman
        $header = "Micare Digitis"
        $coline = "--------------"
        $definition = $definition_micare_digitis
        $help_text = $help_text_micare_digitis

        $fingers_own = Get-Random -Count 1 -InputObject (0..5)
        $fingers_opponent = Get-Random -Count 1 -InputObject (0..5)

        If ($fingers_own -eq 0) { $finger_text = "no fingers (a closed fist)." } ElseIf ($fingers_own -eq 1) { $finger_text = "one finger." } ElseIf (($fingers_own -ge 2) -and ($fingers_own -le 5)) { $finger_text = "$fingers_own fingers." } Else { Write-Verbose "the Dragon (draco, draconis)." -verbose }

        $show = $fingers_own
        $call = ($fingers_own + $fingers_opponent)

        $result = "Call: $($fingers_own + $fingers_opponent)                    Showing $finger_text"


    } ElseIf (($Chinese) -and ($Japanese) -and (-not $Roman)) {

        # Specify the rules - Chinese and Japanese
        $empty_line | Out-String
        Write-Verbose "Please choose, which game to play (either 'Mushi-ken' or 'Shoushiling') by removing either the -Chinese or -Japanese parameter from the command." -verbose
        $empty_line | Out-String
        $duo_text = "These two games cannot effectively be played at the same time since there is no consensus on what will happen if the 'Centipede (wu)' and the 'Slug (namekuji)' confront each other."
        Write-Output $duo_text
        $empty_line | Out-String
        Exit


    } ElseIf (($Chinese) -and ($Roman) -and (-not $Japanese)) {

        # Specify the rules - Chinese and Roman
        $empty_line | Out-String
        Write-Verbose "Please choose, which game to play (either 'Micare Digitis' or 'Shoushiling') by removing either the -Chinese or -Roman parameter from the command." -verbose
        $empty_line | Out-String
        $duo_text = "These two games cannot effectively be played at the same time, because, since the finger count of 'Snake (she)' is so predictable, it refuses to play yet another round of 'Micare Digitis' against 'Centipede (wu)', which on some parts of the world is recognized as the ultimate Grand Master of the game."
        Write-Output $duo_text
        $empty_line | Out-String
        Exit


    } ElseIf (($Roman) -and ($Japanese)-and (-not $Chinese)) {

        # Specify the rules - Roman and Japanese
        $empty_line | Out-String
        Write-Verbose "Please choose, which game to play (either 'Mushi-ken' or 'Micare Digitis') by removing either the -Roman or -Japanese parameter from the command." -verbose
        $empty_line | Out-String
        $duo_text = "These two games cannot effectively be played at the same time since the winner between 'Snake (hebi)' and 'Slug (namekuji)' in 'Micare Digitis' is yet to be decided."
        Write-Output $duo_text
        $empty_line | Out-String
        Exit


    } ElseIf (($Chinese) -and ($Japanese) -and ($Roman)) {

        # Specify the rules - Chinese and Japanese and Roman
        $empty_line | Out-String
        Write-Verbose "Please choose, which game to play (either 'Shoushiling' or 'Mushi-ken' or 'Micare Digitis') by removing two of the included three parameters of -Chinese, -Japanese and -Roman from the command." -verbose
        $empty_line | Out-String
        $trio_text = "These three games cannot effectively be played at the same time since the winner between 'Snake (hebi)' and 'Slug (namekuji)' in 'Micare Digitis' is yet to be decided. Furthermore, there is no consensus on what will happen if the 'Centipede (wu)' and the 'Slug (namekuji)' confront each other in 'Mushi-ken' or 'Shoushiling'. Also, the finger count of 'Snake (she)' is so predictable that it refuses to play yet another round of 'Micare Digitis' against 'Centipede (wu)', which on some parts of the world is recognized as the ultimate Grand Master of the game."
        Write-Output $trio_text
        $empty_line | Out-String
        Exit

    } Else {

       $continue = $true

    } # else (if)




    # Define the audio results
    If (($result -eq "Rock") -or ($result -eq "Slug (namekuji)") -or ($result -eq "Centipede (wu)")) {
        $audio_result = ([char]7)
    } ElseIf (($result -eq "Paper") -or ($result -eq "Snake (hebi)") -or ($result -eq "Snake (she)")) {
        $audio_result = ([char]7, [char]7, [char]7)
    } ElseIf (($result -eq "Scissors") -or ($result -eq "Frog (kawazu)") -or ($result -eq "Frog (wa)")) {
        $audio_result = ([char]7, [char]7, [char]7, [char]7, [char]7)
    } Else {
       $continue = $true
    } # else


    If ($fingers_own -eq 0) { $audio_result = $null
    } ElseIf ($fingers_own -eq 1) { $audio_result = ([char]7)
    } ElseIf ($fingers_own -eq 2) { $audio_result = ([char]7, [char]7)
    } ElseIf ($fingers_own -eq 3) { $audio_result = ([char]7, [char]7, [char]7)
    } ElseIf ($fingers_own -eq 4) { $audio_result = ([char]7, [char]7, [char]7, [char]7)
    } ElseIf ($fingers_own -eq 5) { $audio_result = ([char]7, [char]7, [char]7, [char]7, [char]7)
    } Else {
       $continue = $true
    } # else


} # Process




End {


    # Clear the screen (number 1) and display the help if set to do so
    If (-not $Help) {

        cls
        $empty_line | Out-String
        $empty_line | Out-String
        $empty_line | Out-String
        $empty_line | Out-String
        $empty_line | Out-String
        $header | Out-String
        $coline | Out-String

    } ElseIf ($Help) {

        cls
        $empty_line | Out-String
        $empty_line | Out-String
        $empty_line | Out-String
        $empty_line | Out-String
        $empty_line | Out-String
        $header | Out-String
        $coline | Out-String

        Write-Output $definition
        $empty_line | Out-String
        Write-Output $help_text
        $empty_line | Out-String

    } Else {

       $continue = $true

    } # else (if)




        # Notify the user, if the delay is over the delay_notify_threshold
        If ($Delay -gt $delay_notify_threshold) {

                    # Calculate common variables for the delay_notify_threshold
                    $result_ready = [DateTime]::Now.AddMilliseconds($Delay)
                #   $result_ready = Get-Date ((Get-Date).AddMilliseconds($Delay))
                    $result_ready_date = $result_ready.ToShortDateString()
                    $result_ready_time = Get-Date ($result_ready) -Format HH:mm:ss
                    $result_wait_time = Get-TimeDifference((New-TimeSpan -seconds ($Delay/1000)))

            Write-Verbose "A total wait time of $result_wait_time initiated." -verbose
            $empty_line | Out-String
            "The result will be given on $result_ready_date at $result_ready_time o'clock. To set this countdown to zero (and to get the result within the next second), after selecting this PowerShell window as the active window (by for instance clicking on the window header) please press the letter q on the keyboard or tap the [Esc] key twice. To stop this countdown and to close this script immediately without showing any results, please use the Ctrl + C key combination after selecting this PowerShell window as the active window." | Out-String

        } Else {
            $continue = $true
        } # else (if)




    # Determine if there's a real need for the progress bar and the timer and display in console accordingly
    $wait_time_total = ([DateTime]::Now.AddMilliseconds($Delay)) - (Get-Date)
    $total_seconds = [int]$wait_time_total.TotalSeconds


    If ($total_seconds -lt 1) {

        $a_progressbar_will_be_shown = $false
        Start-Sleep -m $Delay
        $continue = $true

    } Else {

        $a_progressbar_will_be_shown = $true
        Start-Sleep -m $wait_time_total.Milliseconds

        # Set the progress bar variables
        $countdown_id       = 1 # For using more than one progress bar
        $countdown_status   = " "


        # Start the progress bar and a timer
        $timer = [System.Diagnostics.Stopwatch]::StartNew()
        Write-Progress -Id $countdown_id -Activity $header -Status $countdown_status -CurrentOperation "Time Elapsed: 00:00:00      Step: 1" -PercentComplete 0
        Write-Host "`rResult:                              $total_seconds              " -NoNewline


        # Update the progress bar and the timer once in a second                              # Credit: Martin Pugh: "Start-Countdown"
        ForEach ($step in (1..$total_seconds)) {

            Start-Sleep -Seconds 1
            $time_elapsed = $timer.Elapsed


            # Update the progress bar                                                         # Credit: Jeff: "Powershell show elapsed time"
            Write-Progress -Id $countdown_id -Activity $header -Status $countdown_status -CurrentOperation "$([string]::Format('Time Elapsed: {0:d2}:{1:d2}:{2:d2}', $time_elapsed.Hours, $time_elapsed.Minutes, $time_elapsed.Seconds))      Step: $($step + 1)" -PercentComplete (($step / $total_seconds) * 100)


            # Update the timer                                                                # Credit: Jeff: "Powershell show elapsed time"
            If ($($total_seconds - $step) -gt 0) {
                Write-Host $([string]::Format("`rResult:                              $($total_seconds - $step)              ")) -NoNewline
            } Else {
                Write-Host $([string]::Format("`rResult:                                            ")) -NoNewline
            } # else


            # Specify [Esc] and [q] as the Cancel-key                                         # Credit: Jeff: "Powershell show elapsed time"
            If ($Host.UI.RawUI.KeyAvailable -and ("q" -eq $Host.UI.RawUI.ReadKey("IncludeKeyUp,NoEcho").Character)) {
                Write-Host " ...Stopping the Count Down and the Timer...";
                Break;
            } ElseIf ($Host.UI.RawUI.KeyAvailable -and (([char]27) -eq $Host.UI.RawUI.ReadKey("IncludeKeyUp,NoEcho").Character)) {
                Write-Host " ...Stopping the Count Down and the Timer..."; Break;
            } Else {
                $continue = $true
            } # else

        } # foreach


        # Close the progress bar
        Write-Progress -Id 1 -Activity $header -Status $countdown_status -PercentComplete 100 -Completed
        $empty_line | Out-String


    } # else (progress bar)




    # Clear the screen (number 2) and display the results
    $print = "Result:                              $result"


        If (-not $Help) {

            cls
            $empty_line | Out-String
            $empty_line | Out-String
            $empty_line | Out-String
            $empty_line | Out-String
            $empty_line | Out-String
            $header | Out-String
            $coline | Out-String


                If ($Delay -gt $delay_notify_threshold) {
                    $empty_line | Out-String
                    $empty_line | Out-String
                    $empty_line | Out-String
                    $empty_line | Out-String
                } Else {
                    $continue = $true
                } # else (if)


            Write-Output $print

                If ($Audio) {
                    Write-Host $audio_result | Out-Null
                } Else {
                    $continue = $true
                } # else (if)

            Return $empty_line


        } ElseIf ($Help) {

            cls
            $empty_line | Out-String
            $empty_line | Out-String
            $empty_line | Out-String
            $empty_line | Out-String
            $empty_line | Out-String
            $header | Out-String
            $coline | Out-String

            Write-Output $definition
            $empty_line | Out-String
            Write-Output $help_text
            $empty_line | Out-String


                If ($Delay -gt $delay_notify_threshold) {
                    $empty_line | Out-String
                    $empty_line | Out-String
                    $empty_line | Out-String
                    $empty_line | Out-String
                } Else {
                    $continue = $true
                } # else (if)

            Write-Output $print

                If ($Audio) {
                    Write-Host $audio_result | Out-Null
                } Else {
                    $continue = $true
                } # else (if)

            Return $empty_line


        } Else {

            $continue = $true

        } # else (if)


} # End




# [End of Line]


<#

  _    _ _     _
 | |  | (_)   | |
 | |__| |_ ___| |_ ___  _ __ _   _
 |  __  | / __| __/ _ \| '__| | | |
 | |  | | \__ \ || (_) | |  | |_| |
 |_|  |_|_|___/\__\___/|_|   \__, |
                              __/ |
                             |___/



  _____            _                                                       _
 |  __ \          | |                                                     (_)
 | |__) |___   ___| | ________ _ __   __ _ _ __   ___ _ __ ______ ___  ___ _ ___ ___  ___  _ __ ___
 |  _  // _ \ / __| |/ /______| '_ \ / _` | '_ \ / _ \ '__|______/ __|/ __| / __/ __|/ _ \| '__/ __|
 | | \ \ (_) | (__|   <       | |_) | (_| | |_) |  __/ |         \__ \ (__| \__ \__ \ (_) | |  \__ \
 |_|  \_\___/ \___|_|\_\      | .__/ \__,_| .__/ \___|_|         |___/\___|_|___/___/\___/|_|  |___/
                              | |         | |
                              |_|         |_|

Write-Verbose "Rock-paper-scissors" -verbose


The Paper Scissors Stone Club was founded in London, England in 1842. The charter
appeared in Edition 1, Volume 1, of the club's publication, The Stone Scissors
Paper. It read,"The club is dedicated to the exploration and dissemination of
knowledge regarding the game of Paper Scissors Stone and providing a safe legal
environment for the playing of said game." In 1918, the club's name was changed
to World RPS Club. Soon after that, the club moved its headquarters to Toronto,
Canada. In 1925, the club had more than 10,000 active members, changed its name
the World RPS Society, and hosted its first annual championship.

Starting in 2002, the World Rock Paper Scissors Society standardized a set of
rules for international play and has overseen annual International World
Championships.


        THE WORLD RPS SOCIETY – OFFICIAL ABRIDGED RULES OF PLAY


        1.0     The Game is played where the players substitute the three elements
                of Rock, Paper and Scissors with representative hand signals.

        2.0     These hand signals are delivered simultaniously by the players

        3.0     The Outcome of play is determined by the following


                    Rock wins against Scissors
                    Scissors wins against Paper
                    Paper wins against Rock


The basics of the game consist of each player shaking a fist a number of times
("priming") and then extending the same hand in a fist ✊ ("rock"), out
flat ✋ ("paper"), or with the index and middle fingers extended ✌️ ("scissors").
Each of these is referred to as a throw, and which one wins is dependent upon the
opponent's throw. If each player makes the same throw, the round is a stalemate,
and must be replayed.


        Paper wins against Rock     ("Paper covers rock")
        Rock wins against Scissors  ("Rock dulls or crushes the scissors")
        Scissors wins against Paper ("Scissors cut paper")


The Pre-Steps (prime) – The Approach – The Delivery

During the pre-steps (prime) ritual it is customary to use 90 degrees motion when
counting down the steps. A pre-step consists of the action of retracting one's fist
from full-arm extension towards the shoulder and then back to full extension. The
Approach is the transition phase between the final pre-step and the Delivery. The
Approach begins at the shoulder following the final prime and ends when the arm
makes a 90-degree angle with the player's body. Players must reveal their chosen
throw to their opponent prior to reaching the 90-degree mark. Any throw delivered
past this critical point must be considered a 'Forced Rock' (since this is the
position the hand would have been in upon crossing the 90-degree mark). So once
firmly in the Approach phase, it is time to shift focus to the Delivery. Since the
hand is technically already in the Rock position, it must either be switched to
another throw or remain as Rock. It is customary to try to time the possible
transition from 'Rock' to some other option as late as possible, so the opponent
doesn't have the time to read the throw and possibly adjust to what is being played.

Analyzing what happens in the Approach phase lays in the heart of 
'Rock-paper-scissors' and judging the events occuring during that penultimate phase
for the most part decides the fairness of the gameplay. While it seems, that this 
1 ms machine http://www.k2.t.u-tokyo.ac.jp/fusion/Janken/index-e.html has a 100 %
win rate against any human opponent, it actually is throwing "forced rocks" every 
time (even in its second version), since the decision, what signal should be shown, 
is made by the machine after the artificial hand has reached its lowest position, 
which could resemble the 90-degree angle with its human opponents. This 
1-ms-responce-time-machine can be beaten every time by throwing a paper against it 
and declaring that its throw should be nullified as a "forced rock", since the 
resulting "Scissors" was decided by the machine after the artificial hand had 
reached its lowest position and at the time the artificial hand had reached its 
lowest position the hand was showing a "Rock" signal and after the artificial hand 
had reached its lowest position the machine then (quickly) changed its throw.


Multiplayer Modes

A multiple player variation can be played: Players stand in a circle and all throw
at once. If rock, paper, and scissors are all thrown, it is a stalemate, and the 
round is replayed. If one option is delivered by all participants, the 'Tie-Break 
Situation' is resolved by playing another round of 'Rock-paper-scissors' immediately 
after the existence of 'Tie-Break Situation' has been confirmed. If only two throws 
are present, all players with the losing throw are eliminated. The play continues 
until only the winner remains.


Classic 'Rock-paper-scissors'

  	                    ROCK  	        PAPER  	        SCISSORS
ROCK  	                Tie 	        Paper           Rock
PAPER 	                Paper           Tie  	        Scissors
SCISSORS  	            Rock  	        Scissors   	    Tie


'Rock-paper-scissors'
Rock        🗻
Paper       📰
Scissors    ✂
Dynamite    💣


Source:     http://worldrps.com/game-basics/
            http://worldrps.com/the-myth-of-dynamite-exposed/
            http://wpedia.goo.ne.jp/enwiki/Rock,_paper,_scissors
            https://thedailyomnivore.net/2016/08/14/rock-paper-scissors/
            http://www.straightdope.com/columns/read/1936/whats-the-origin-of-rock-paper-scissors
            https://www.psychologytoday.com/blog/the-blame-game/201504/the-surprising-psychology-rock-paper-scissors







   _____ _                     _     _ _ _
  / ____| |                   | |   (_) (_)
 | (___ | |__   ___  _   _ ___| |__  _| |_ _ __   __ _
  \___ \| '_ \ / _ \| | | / __| '_ \| | | | '_ \ / _` |
  ____) | | | | (_) | |_| \__ \ | | | | | | | | | (_| |
 |_____/|_| |_|\___/ \__,_|___/_| |_|_|_|_|_| |_|\__, |
                                                  __/ |
                                                 |___/

Write-Verbose "Shoushiling (Shoushìlìng: traditional Chinese: 手勢令; literally: 'hand command')" -verbose


Shoushiling 手勢令 ('hand command') - Chinese


Five Poisons        The five poisons (五毒), also known as the "Five Poisonous
                    Creatures", refer to five poisonous animals which usually
                    include the snake, scorpion, centipede, toad and a spider.

                    Sometimes, the lizard replaces the spider. The "three-legged
                    toad" is frequently included as one of the five. The Chinese
                    believed that the five poisons counteract pernicious
                    influences by combating poison with poison.

Snake               The snake or a serpent (she, shé 蛇) is a member of the Chinese
                    zodiac and also a member of the "Five Poisons".

Frog                The frog (wa 蛙) is a symbol of fertility because it has the
                    same pronunciation as the word for baby (wa 娃).

Centipede           The centipede (wu 蜈蚣) is a poisonous small, long, thin animal
                    with many legs and was believed to be capable of killing a
                    snake. A member of the "Five Poisons".


Classic 'Shoushiling' (手勢令) - Chinese

  	                    CENTIPEDE (wu)  SNAKE (she)     FROG (wa)
CENTIPEDE (wu)  	    Tie 	        Centipede       Frog
SNAKE (she) 	        Centipede       Tie  	        Snake
FROG (wa)  	            Frog  	        Snake   	    Tie


'Shoushiling' (手勢令) - Chinese

Centipede   (wu         | 🐛)       (蜈蚣    | wu    | 🐛)
Snake       (she        | 🐍)       (蛇      | she   | 🐍)
Frog        (wa         | 🐸)       (蛙      | wa    | 🐸)
The Dragon  (long       | 🐲)       (龙      | long  | 🐲)




Source:     http://primaltrek.com/impliedmeaning.html
            http://primaltrek.com/fivepoisons.html
            http://dictionary.cambridge.org/dictionary/english-chinese-traditional/centipede
            http://www.internationalscientific.org/CharacterEtymology.aspx?submitButton1=Etymology&characterInput=%E8%9C%88
            http://www.historyofemotions.org.au/media/230620/2015-zest-education-pack-final-web-version.pdf
            Linhart, Sepp (1995). 'Some Thoughts on the Ken Game in Japan: From the Viewpoint of Comparative Civilization Studies. Senri Ethnological Studies 40: 101-124. http://tinyurl.com/zju37c2"
            https://minpaku.repo.nii.ac.jp/?action=pages_view_main&active_action=repository_view_main_item_detail&item_id=3017&item_no=1&page_id=13&block_id=21







  __  __           _     _        _
 |  \/  |         | |   (_)      | |
 | \  / |_   _ ___| |__  _ ______| | _____ _ __
 | |\/| | | | / __| '_ \| |______| |/ / _ \ '_ \
 | |  | | |_| \__ \ | | | |      |   <  __/ | | |
 |_|  |_|\__,_|___/_| |_|_|      |_|\_\___|_| |_|


Write-Verbose "Mushi-ken (虫拳) (one of the Japanese games of 'sansukumi-ken' (三竦み拳)" -verbose


'Mushi-ken' 虫拳 (ken ('fist') of the small animals, one of the games of
'sansukumi-ken' (ken ('fist') of the three who are afraid of one another)) - Japanese


Classic 'Mushi-ken' (虫拳) - Japanese

  	                    SLUG (namekuji)     SNAKE (hebi)    FROG (kawazu)
SLUG (namekuji)  	    Tie 	            Slug            Frog
SNAKE (hebi) 	        Slug                Tie  	        Snake
FROG (kawazu)  	        Frog  	            Snake   	    Tie


'Mushi-ken' (虫拳) - Japanese

Slug, a shell-less 'snail'  (namekuji / namekujiri  | 🐌)   (なめくじ                  | 蛞蝓  | 🐌)
Snake                       (hebi                   | 🐍)   (へび                    | 蛇    | 🐍)
Frog                        (kawazu (modern: kaeru) | 🐸)   (かわず (modern: かえる)) | 蛙    | 🐸)
The Dragon                  (ryuu                   | 🐲)   (りゅう                   | 竜    | 🐲)




Source:     http://jisho.org/word/%E8%9B%9E%E8%9D%93
            http://jisho.org/word/%E8%9B%99
            http://jisho.org/word/%E8%9B%87
            http://www.nihongodict.com/w/55269/namekuji/
            http://www.nihongodict.com/w/55784/kaeru/  
            http://www.nihongodict.com/w/31005/hebi/                      
            https://japandaily.jp/decision-making-powers-janken-2626/
            Linhart, Sepp, and Sabine Frühstück: 'The Culture of Japan as Seen through Its Leisure': https://books.google.com/books?id=k_Cb7a6FQwwC&pg=PA325
            Linhart, Sepp (1995). 'Some Thoughts on the Ken Game in Japan: From the Viewpoint of Comparative Civilization Studies. Senri Ethnological Studies 40: 101-124. http://tinyurl.com/zju37c2
            https://minpaku.repo.nii.ac.jp/?action=pages_view_main&active_action=repository_view_main_item_detail&item_id=3017&item_no=1&page_id=13&block_id=21







  __  __ _                      _____  _       _ _   _
 |  \/  (_)                    |  __ \(_)     (_) | (_)
 | \  / |_  ___ __ _ _ __ ___  | |  | |_  __ _ _| |_ _ ___
 | |\/| | |/ __/ _` | '__/ _ \ | |  | | |/ _` | | __| / __|
 | |  | | | (_| (_| | | |  __/ | |__| | | (_| | | |_| \__ \
 |_|  |_|_|\___\__,_|_|  \___| |_____/|_|\__, |_|\__|_|___/
                                          __/ |
                                         |___/

Write-Verbose "Micare Digitis" -verbose

Micare Digitis ('Flashing Fingers' or Counting Fingers)


In Latin the verb 'mico' strictly means, 'to have a tremulous motion imparted'. 
'Micare digitis' properly meant 'to flash with fingers' in a game in which two 
persons suddenly raised or compressed the fingers and at the same moment each 
guessed the total number of fingers raised. It was practised both as a game of 
chance and as a mode of deciding doubtful matters. This game later evolved into 
'mora' or 'morra', which is still played in Italy today.

In antiquity within the Roman cultural sphere, there was a commonly used proverb 
said of a thoroughly honest person, which centered around the concept of 
'micare digitis' (– dignus est, quicum [cum quo] in tenebris mices – 
'So honest is this person, that in the shadows could you play the game of 
'micare digitis' with him'), since it would be so easy to cheat in this game when 
played in the dark.   


                Haec non turpe est dubitare philosophos, quae ne rustici quidem 
                dubitent? A quibus natum est id, quod iam contritum est vetustate, 
                proverbium. Cum enim fidem alicuius bonitatemque laudant, dignum 
                esse dicunt, "quicum in tenebris mices."


                Is it not a shame that philosophers should be in doubt about moral 
                questions on which even peasants have no doubts at all? For it is 
                with peasants that the proverb, already trite with age, originated: 
                when they praise a man's honour and honesty, they say "He is a man 
                with whom you can safely play at odd and even [Lit. 'flash with the 
                fingers'; shoot out some fingers the number of which had to be 
                guessed.] in the dark."


                (Cic. Off. 3.19.77) Marcus Tullius Cicero a.k.a. Κικέρων,
                (106–43 BC): 'De Officiis' 3.19.77
                http://www.gutenberg.org/files/47001/47001-h/47001-h.htm
                https://ia601403.us.archive.org/27/items/mtulliuscicerod00cicegoog/mtulliuscicerod00cicegoog.pdf
                        Sim.       http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A2007.01.0047%3Abook%3D3%3Asection%3D77


In the Satyricon, Gaius Petronius Arbiter (AD 27–66, a.k.a Petronius) tells his 
readers about Trimalchio's dinner party and at that party Ganymedes, according to 
Petronius, tells the other guests about Safinius, that...


                Sed memini Safinium; tunc habitabat ad arcum veterem, me puero: 
                piper, non homo. Is quacunque ibat, terram adurebat. 
                Sed rectus, sed certus, amicus amico, cum quo audacter posses 
                in tenebris micare.


                Why! I remember Safinius; he used to live at the Old Arch when 
                I was a boy. It was a peppercorn, I tell you, not a man. 
                Wherever he went, he made the ground smoke under him. An upright, 
                downright honest man, and a trusty friend, one you might
                confidently play 'mora' with in the dark.


                (Petr. Satyr. 44. XLIV) Gaius Petronius Arbiter (AD 27–66, a.k.a Petronius):
                'Petronii Satiricon Liber' XLIV (The Satyricon XLIV)
                http://www.thelatinlibrary.com/petronius1.html
                http://www.sacred-texts.com/cla/petro/satyr/sat08.htm#XLIV


In fact, 'Micare Digitis' became so deeply enrooted in the cultural landscape of 
Rome, that traces of its usage found its way into legal binding documents, such as 
an edict listed below concerning the validation of a transaction (dating perhaps 
AD 339, when Lucius Turcius Apronianus (father) or AD 363-4, when Lucius Turcius 
Apronianus, signo Asterius (son) was a Praefectus Urbi (of the city of Rome))...


                Ex auctoritate Turci Aproniani v(iri) c(larissimi), Praefecti 
                Urbis. Ratio docuit utilitate suadente, consuetudine micandi 
                summota sub exagio potius pecora vendere, quam digitis 
                conludentibus [concludentibus] tradere,...


                (Inscr. Orell. 3166) Johann Caspar Orelli (c. AD 1787–1849): 
                'Inscriptionum Latinarum selectarum amplissima collectio', 3166. 
                Ad Illustrandam Romanae Antiquitatis by Johann Caspar von Orellius, 
                Wilhelm Henzen. Published 1828. or 'Orellii inscriptionum Latinarum 
                selectarum collectio', 3166: Turici 1828.
                https://archive.org/details/inscriptionumla01henzgoog
                https://ia902608.us.archive.org/21/items/inscriptionumla01henzgoog/inscriptionumla01henzgoog.pdf
                Corpus Inscriptionum Latinarum: CIL VI 1770 (Latin):
                http://arachne.uni-koeln.de/item/buchseite/580887
                And concerning Lucius Turcius Apronianus: 
                http://www.keytoumbria.com/Umbria/4th_Century__Inscriptions_Later_Latin.html
                http://cil.bbaw.de/cil_en/dateien/db_eng.php?nummer=VI+1768&andor=AND&nummer2=&fundort_antik=&fundort_modern=&provinz=
                http://laststatues.classics.ox.ac.uk/database/discussion.php?id=1841


...and to the Christian teachings, where the number three in 'Micare Digitis' was 
used by Aurelius Augustinus Hipponensis (AD 354-430, a.k.a. Augustine of Hippo, 
the coadjutor Bishop of Hippo since 395, who became full Bishop shortly thereafter) 
as a comparison to the concept of Christian 'trinity' within the Christian dogma, 
when trying to define the boundaries of the Christian concept of 'trinity', in the 
eight book of 'De Trinitate' (VIII.5.8) (On the trinity), published perhaps around 
AD 417, but certainly between AD 400 and 428...


                [8] Quamobrem quoniam trinitatis aeternitatem et aequalitatem et 
                unitatem quantum datur intellegere cupimus, prius autem quam 
                intellegamus credere debemus vigilandumque nobis est ne ficta sit 
                fides nostra. Eadem quippe trinitate fruendum est ut beate vivamus; 
                si autem falsum de illa crediderimus, inanis erit spes et non 
                casta caritas. Quomodo igitur eam trinitatem quam non novimus 
                credendo diligimus?
                (...)
                Cum ergo dicimus et credimus esse trinitatem, novimus quid sit 
                trinitas quia novimus quid sint tria; sed hoc non diligimus. 
                Nam id ubi volumus facile habemus, ut alia omittam vel micando 
                digitis tribus. An vero diligimus non quod omnis trinitas sed 
                quod trinitas deus?


                [8] Wherefore, since we desire to understand the eternity, and 
                equality, and unity of the trinity, as much as is permitted us, 
                but ought to believe before we understand; and since we must watch 
                carefully, that our faith be not feigned; since we must have the 
                fruition of the same trinity, that we may live blessedly; but if 
                we have believed anything false of it, our hope would be worthless, 
                and our charity not pure: how then can we love, by believing, 
                that trinity which we do not know?
                (...)
                When, therefore, we say and believe that there is a trinity, we 
                know what a trinity is, because we know what three are; but this is 
                not what we love. For we can easily have this whenever we will, to 
                pass over other things, by just holding up three fingers [lit. 
                flashing three fingers]. Or do we indeed love, not every trinity, 
                but the trinity, that is god?


                Aurelius Augustinus Hipponensis (AD 354–430, a.k.a. Augustine of 
                Hippo): 'De Trinitate' Liber VIII.5.8 (On the trinity, Book VIII 
                Chapter 5.8)
                http://www.thelatinlibrary.com/augustine/trin8.shtml
                http://www.newadvent.org/fathers/130108.htm


...and to the poetry, as Titus Calpurnius Siculus (perhaps second or third 
century AD) in his second pastoral poem in 'Eclogue' (sometimes inscribed as Crotale)
has his characters Astacus and Idas about to be endulged in an amoebaean song contest, 
when Thyrsis (which might be a nod to the same Thyrsis, which appears on the Bucolic 
Idyll 1 by Θεόκριτος (c. 3rd century BC, a.k.a. Theokritos, a.k.a. Theocritus, the 
creator of ancient Greek bucolic poetry) declares that the prize should be glory 
alone and that the starter should be decided by the best score out of three rounds 
of 'Micare Digitis':


                Convenit umbrosa quicumque sub ilice lentas
                pascit oves, Faunusque pater Satyrique bicornes;
                Adfuerunt sicco Dryades pede, Naides udo,
                et tenuere suos properantia flumina cursus;
                Desistunt tremulis incurrere frondibus Euri
                altaque per totos fecere silentia montes:
                Omnia cessabant, neglectaque pascua tauri
                calcabant, illis etiam certantibus ausa est
                daedala nectareos apis intermittere flores.
                Iamque sub annosa medius consederat umbra
                Thyrsis et "O pueri me iudice pignora," dixit,
                "irrita sint moneo: satis hoc mercedis habeto,
                si laudem victor, si fert opprobria victus.
                Et nunc alternos magis ut distinguere cantus
                possitis, ter quisque manus iactate micantes."
                Nec mora: decernunt digitis, prior incipit Idas.


                There met every shepherd who feeds his lazy flocks beneath the shady 
                oak, and Father Faunus too and the twy-horned Satyrs. Dry-foot the 
                wood-nymphs came; with watery feet the river-nymphs; and hastening 
                torrents stayed their courses. East-winds ceased their rush upon the 
                quivering leaves and so made deep silence over all the hills; 
                everything stood idle; bulls trampled the pasture, which they heeded 
                not; during that contest even the craftsman bee ventured to leave
                unvisited the nectar-yielding flowers. Now under the shade of an 
                aged tree had Thyrsis taken his seat between them and said, "Lads, 
                if I am to be judge, I urge that the stakes count for nothing. Let 
                suffer recompense be won herefrom, if the victor take the glory and 
                the vanquished the reproach. Now, the better to mark off your 
                alternate songs, raise in sudden movement each your hands three 
                times." They obey at once. The finger-trial decides, 
                and Idas begins first.


                (Calp. Sic. 2, 12–27) Titus Calpurnius Siculus (perhaps second or 
                third century AD): 'Eclogis Calpurni Siculi' 2, 12–27 
                (Eclogues of Calpurnius Siculus 2, 12–27)
                http://penelope.uchicago.edu/Thayer/L/Roman/Texts/Calpurnius_Siculus/Eclogues/2*.html
                https://ia601406.us.archive.org/33/items/ecloguesofcalpur00calpuoft/ecloguesofcalpur00calpuoft.pdf
                http://penelope.uchicago.edu/Thayer/L/Roman/Texts/Calpurnius_Siculus/Eclogues/2*.html


The tradition of 'Micare Digitis' continued uninterruptedly at least to the times of
Desiderius Erasmus Roterodamus (AD 1466–1536, a.k.a. Erasmus of Rotterdam a.k.a. 
Erasmus), since with a spectacular accuracy he is able to describe the intrinsics of 
'Micare Digitis' under the header 'Dignvs Qvicvm in Tenebris Mices' in his collection 
of Greek and Latin proverbs called 'Collectanea Adagiorum' (Adages), which dates to 
AD 1500, 1508, 1515 or 1533 depending on the edition, and which in its latest edition 
lists over four thousand items (first edition included 818 proverbs):


                Qui certissima esset fide, eum dignum dicebant quicum in tenebris
                micaretur. (...) Est autem micare lusus genus quoddam, quod adhuc 
                apud Italos durat, ut repente porrectis digitis certantium uterque 
                numerum divinet. (...) Porro quicum micas in tenebris, ei liberum 
                est, si velit fallere. Proinde dignus quicum in tenebris mices 
                dicitur, qui sit usqueadeo certa fide, ut nec si tuto possit, velit 
                quempiam mendacio fallere. (...)


                Desiderius Erasmus Roterodamus (AD 1466–1536, a.k.a. Erasmus of 
                Rotterdam a.k.a. Erasmus): 'Collectanea Adagiorum' 723. I, VIII, 23. 
                (A Collection of Greek and Latin proverbs 723. I, VIII, 23. - 
                The 'Adages' of Erasmus)
                http://jvpoll.home.xs4all.nl/back/Web/erasweb8.htm#a723
                https://web.archive.org/web/20110929193309/http://sites.univ-lyon2.fr/lesmondeshumanistes/wp-content/uploads/2010/09/Adages-tome-1.pdf
                https://web.archive.org/web/20110619002744/http://sites.univ-lyon2.fr:80/lesmondeshumanistes/category/adages-erasme/
                https://web.archive.org/web/20120114123112/http://sites.univ-lyon2.fr/lesmondeshumanistes/wp-content/uploads/Adages.pdf
                http://www.andreascenter.org/Articles/Erasmus.htm
                http://quod.lib.umich.edu/e/eebo/A38569.0001.001/1:2?rgn=div1;view=fulltext


When trying to find out the origins of the game of 'micare digitis', as already 
pointed out by Marcus Tullius Cicero (106–43 BC, a.k.a. Κικέρων), the proverb 
concerning playing 'micare digitis' in the dark was already quite old in his own 
time (Cic. Off. 3.19.77), but furthermore in another part of 'De Officiis' Cicero 
seems also to be indicating that the praxis of 'micare digitis' was not unknown to 
the Greek either, when he is discussing the works of Ἑκάτων (c. first-second 
century BC, a.k.a. Hecaton of Rhodes, a.k.a. Hecaton) (Cic. Off. 3.23.89–90):


                Plenus est sextus liber de officiis Hecatonis talium quaestionum: 
                (...)
                "Quid? si una tabula sit, duo naufragi, eique sapientes, sibine 
                uterque rapiat, an alter cedat alteri?"
                Ἑκάτων: "Cedat vero, sed ei, cuius magis intersit vel sua vel rei 
                publicae causa vivere."
                "Quid, si haec paria in utroque?"
                Ἑκάτων: "Nullum erit certamen, sed quasi sorte aut micando victus 
                alteri cedet alter."


                The sixth book of of the Stoic philosopher Hecaton's "Moral Duties" 
                is full of questions like the following:
                (...)
                "Again; suppose there were two to be saved from the sinking 
                ship—both of them wise men—and only one small plank, should both 
                seize it to save themselves? Or should one give place to the other?"
                Hecaton: "Why of course, one should give place to the other, but 
                that other must be the one whose life is more valuable either for 
                his own sake or for that of his country."
                "But what if these considerations are of equal weight in both?"
                Hecaton: "Then there will be no contest, but one will give place 
                to the other, as if the point were decided by lot or at a game of 
                odd and even."


                (Cic. Off. 3.23.89-90) Marcus Tullius Cicero a.k.a. Κικέρων,
                (106–43 BC): 'De Officiis' 3.23.89-90
                http://www.gutenberg.org/files/47001/47001-h/47001-h.htm
                https://ia601403.us.archive.org/27/items/mtulliuscicerod00cicegoog/mtulliuscicerod00cicegoog.pdf
                        Sim.       http://www.perseus.tufts.edu/hopper/text?doc=Cic.+Off.+3.89&fromdoc=Perseus%3Atext%3A2007.01.0047


A Roman scholar and writer Marcus Terentius Varro (116–27 BC, a.k.a. Varro Reatinus 
a.k.a. Varro) is indeed confirming, that 'micare digitis' is known in the realm of 
ancient Greece, too, in one of the fragments of Menippean Satires


                Micandum erit cum Graeco, utrum ego illius numerum an ille 
                meum sequatur.


                I'll play morra with the Greek, to see whether I'll imitate 
                his number, or he mine.


                Marcus Terentius Varro (116–27 BC, a.k.a. Varro Reatinus 
                a.k.a. Varro): 'M. Terentii Varronis Saturae Menippeae' LXIII. 
                Parmeno 388. 347, 26 
                (Satires fragment LXIII. Parmeno 388. 347, 26 (396.1))
                http://www.forumromanum.org/literature/menippeae.html
                https://archive.org/stream/satiraeetliberpr00petruoft/satiraeetliberpr00petruoft_djvu.txt
                'M. Terentius Varronis Saturarum Menippearum reliquiae': LXVI. PARMENO. 186.10.
                https://archive.org/stream/mterentiusvarro00oehlgoog/mterentiusvarro00oehlgoog_djvu.txt
                http://www.philological.bham.ac.uk/polyadag/1alat.html


However, it is Πτολεμαῖος Ἡφαιστίων (a.k.a. Ptolemaios Hephaestion a.k.a. Ptolemaeus 
Hephaestion a.k.a. Ptolemy Hephaestion) according to whom the tradition of 
'Micare Digitis' may have originated from Ἑλένη (a.k.a. Helen of Troy, who usually 
was considered to be a daughter of Zeus and Leda and the sister of Polydeuces and 
Castor (the Dioscuri); some traditions called her a daughter of Zeus and Nemesis), 
a view that is preserved only in the second hand sources, most notably in a work by 
Φώτιος (c. AD 810–893, a.k.a. Photios I of Constantinople, a.k.a. Photius, a.k.a. 
Fotios, the Ecumenical Patriarch of Constantinople AD 858–867 and AD 877–886) called 
Βιβλιοθήκη (Library), which is a collection of 280 codices (chapters or full 
volumes) devoted to ancient authors, in each citing extracts of the original text 
or providing summaries of the texts of the originals, which to a great extent are 
now believed to be lost as originals. In the 190th codex (cod. 190) of Βιβλιοθήκη, 
Φώτιος records a work by Πτολεμαῖος Ἡφαιστίων in six books, which is usually 
assigned to Πτολεμαῖος Χέννος (2nd century AD, a.k.a. Ptolemaeus Chennus a.k.a. 
Ptolemy Chennos of Alexandria a.k.a. Ptolemy Chennos, who was was a Greek grammarian
and might or might not be a son of a certain Hephaestion), in which many details and
characters seem to have been invented by the author, rather than come from the 
arduous work of research and as such could be considered as a visionary rather 
than a historical document:


                Ἀνεγνώσθη Πτολεμαίου τοῦ Ἡφαιστίωνος περὶ τῆς εἰς πολυμαθίαν καινῆς 
                ἱστορίας λόγοι Ϛ'. Χρήσιμον ὡς ἀληθῶς τὸ βιβλίον τοῖς περὶ τὴν 
                ἱστορικὴν πολυμαθίαν πονεῖν ὡρμημένοις· ἔχει γὰρ δοῦναι συνειλεγμένα 
                βραχεῖ χρόνῳ εἰδέναι, ἃ σποράδην τις τῶν βιβλίων ἀναλέγειν πόνον 
                δεδεγμένος μακρὸν κατατρίψει βίον. Ἔχει δὲ πολλὰ καὶ τερατώδη καὶ 
                κακόπλαστα, καὶ τὸ ἀλογώτερον, ὅτι καὶ ἐνίων μυθαρίων αἰτίας, δι´ 
                ἃς ὑπέστησαν, ἀποδιδόναι πειρᾶται.

                Ὁ μέντοι τούτων συναγωγεὺς ὑπόκενός τέ ἐστι καὶ πρὸς ἀλαζονείαν 
                ἐπτοημένος, καὶ οὐδ´ ἀστεῖος τὴν λέξιν. Προσφωνεῖ δὲ τὸ σύνταγμα 
                Τερτύλλᾳ τινί, ἣν καὶ δέσποιναν ἀνυμνεῖ καὶ τὸ φιλολόγον αὐτῇ καὶ 
                πολυμαθὲς ἐπιφημίζει. Διαβάλλει δ´ ἐνίους καὶ τῶν πρὸ αὐτοῦ οὐχ 
                ὑγιῶς ἐπιβαλόντας τῇ ὑποθέσει. Τά γε μὴν πλεῖστα τῶν ἱστορουμένων 
                ὑπ´ αὐτοῦ, καὶ ὅσα τοῦ ἀπιθάνου καὶ ἀπίστου καθαρεύει, παρηλλαγμένην
                ὅμως καὶ οὐκ ἄχαρι εἰδέναι τὴν μάθησιν ἐμπαρέχει.
                (...)
                Τὸ δὲ δʹ διεξέρχεται ὡς Ἑλένη πρώτη ἐπενόησε τὸν διὰ δακτύλων 
                κλῆρον, καὶ Ἀλεξάνδρῳ λαχοῦσα ἐνίκησε· καὶ ὡς Ἀφροδίτης εἴη θυγάτηρ.


                Read Ptolemy Hephaestion, New History, intended for scholarship in 
                six books, a work really useful for those who undertake to attempt 
                erudition in history; it can, in fact, give the method to know in a 
                short time connected elements, whereas a long life would be consumed 
                in the effort of locating them in the books through which they are 
                scattered. It abounds in extraordinary and badly imagined 
                information; and the peak of absurdity is that he attempts, for 
                certain trivial fables, to explain the reasons for their appearance.

                As for the collector who has assembled these stories, he is a 
                somewhat credulous spirit, inclined to boastfulness and who has no 
                other distinction in his language. He dedicates his work to a 
                certain Tertulla whom he celebrates as his "lady" and whose love for
                letters and scholarship he praises. He attacks some of his 
                detractors whom he accuses of having approached the subject in an 
                unhealthy way. In any case, the majority of his stories which are 
                free of things impossible to believe, offer a knowledge above the 
                ordinary, but which is not unpleasing.
                (...)
                The fourth recounts that Helen was the first to imagine drawing lots
                with the fingers and that she won at chance with Alexander; she was 
                the daughter of Aphrodite [usually Helen was considered to be a 
                daughter of Zeus and Leda and the sister of Polydeuces and Castor 
                (the Dioscuri); some traditions called her a daughter of Zeus and 
                Nemesis].


                Φώτιος (c. AD 810–893, a.k.a. Photios I of Constantinople, a.k.a. 
                Photius, a.k.a. Fotios, the Ecumenical Patriarch of Constantinople 
                AD 858–867 and AD 877–886): Βιβλιοθήκη (Library) or Μυριόβιβλος 
                (Myriobiblos, "Ten Thousand Books"), 190. Ptolemy Chennus, New History
                http://remacle.org/bloodwolf/erudits/photius/ptolemee.htm
                http://www.tertullian.org/fathers/photius_copyright/photius_05bibliotheca.htm#190
                http://www.english.illinois.edu/maps/poets/g_l/hd/abouthelen.htm
                http://www.photius.com/photios/photios15.html
                https://archive.org/stream/adictionarygree00smitgoog/adictionarygree00smitgoog_djvu.txt
                https://ia800304.us.archive.org/0/items/adictionarygree00smitgoog/adictionarygree00smitgoog.pdf


Even though Helen of Troy with her "invention" of the game of 'Micare Digitis' lays 
deep down early in the Western Cultural History, the roots of 'Micare Digitis' might 
be able to be traced to times that predate even Helen of Troy, since according to 
Anthony Rich, who wrote the Dictionary of Roman And Greek Antiquities originally 
in 1884, 'Micare Digitis' or 'micatio' is...


                a game of chance, combined with skill, still common in the south of 
                Italy, where it now goes by the name of Morra. (Varro. ap. Non. 
                s. v. p. 547. Calpurn. Ed. ii. 26.) It is played by two persons in 
                the following manner. Both hold up their right hands with the fist 
                closed; they then simultaneously extend a certain number of their 
                fingers, calling out at the same time by guesswork the collective 
                number extended by the two together, and he who succeeds in naming 
                the right number wins the game. The annexed figures, representing a 
                couple of Egyptians playing at morra from a painting in the tombs, 
                testify the very great antiquity of the game, and will serve to 
                convey a distinct notion of the manner in which it was conducted to 
                those who have never seen it played. It is the same as that still 
                practised, with the exception that the performers are in a sitting 
                instead of a standing posture, as is now usual; and that they appear 
                to make use of all their fingers, instead of the right hand only, 
                which must have greatly increased the difficulty and intricacy of 
                the game, as it admits the various combinations which might be made 
                out of twenty numbers instead of ten only. The right-hand figure has 
                extended all the fingers of his right hand, and three of his left; 
                his opponent puts out two with the right hand, and three on the left 
                one; thus the number exhibited is thirteen. If either of the parties 
                cry out "thirteen" at the moment of opening their hands, but before 
                the opened fingers are actually displayed, he wins; if neither 
                succeeds in guessing right, they again close their hands, cry out 
                a number, and open the fingers until one of them calls the right 
                amount. What appears to be so simple is most difficult to execute 
                with any chance of success, and requires more skill and calculation 
                than a person, who had not himself made the experiment, would imagine.

                Each player has first to settle in his own mind how many fingers he 
                will show; then to surmise how many his opponent is likely to put up, 
                which he does by observing his usual style of play, by remembering 
                the numbers he last called, and those he last showed; he then adds 
                these to his own, and calls the collective number, thus endeavouring 
                to make the number which he calls. But as all this which takes so 
                much time in narrating, is actually done with the greatest rapidity, 
                the hands being opened and closed, and the numbers simultataneously 
                called as fast as one can pronounce them — eight, two, six, ten — it 
                requires great readiness of intellect and decision of purpose, for 
                a player to have any chance of winning, as well as a quick eye and 
                acute observation, to see in a moment the aggregate number of fingers 
                shown, so at not to overlook his own success; nor, on the other hand, 
                suffer himself to be imposed upon by a more astute opponent.


                Anthony Rich: A Dictionary of Roman and Greek Antiquities: Micatio or 
                digitis micare, page 422–423 with Nearly 2000 Engravings on Wood from 
                Ancient Originals. Published 1884 or 1893.
                http://www.archive.org/stream/adictionaryroma00richgoog#page/n429/mode/2up
                https://archive.org/download/adictionaryroma00richgoog/adictionaryroma00richgoog.pdf
                https://archive.org/stream/adictionaryroma00richgoog/adictionaryroma00richgoog_djvu.txt


In its rich history 'Micare Digitis' has had a wide cultural impact, which is 
demonstrated to us, for instance, by J.J.M. de Groot, since when discussing the 
annual festivals celebrated in Émoi he makes a remark that 'Micare Digitis' with the 
identical set of rules is also known in China by the name 'hoah-koûn' («crier le poing» 
or "shout fist"):


                C'est le micare digitis ou la micatio des anciens Romains, qui n'a 
                pas seulement subsisté en Italie sous le nom de morra, mais qui 
                existe aussi en Chine sous le nom de «crier le poing» (à Émoui 
                hoah-koûn). Il se joue par deux personnes, qui ouvrent en même temps
                chacune le nombre de doigts de la main droite qu'elles veulent en 
                nommant du même coup la somme qu'elles présument devoir être celle 
                des doigts ouverts; celle qui devine juste a gagné et impose une 
                peine à l'autre. Si les deux joueurs devinent juste ou si tous les 
                deux se trompent, le coup est nul. Naturellement il n'est pas permis
                de prononcer la somme avant ou après le moment précis ou les mains 
                s'avancent et les doigts s'ouvrent. Quelque simple que semble ce jeu,
                il réclame beaucoup de vivacité d'esprit. En effet le joueur doit 
                à chaque coup accomplir avec rapidité trois opérations, déterminer 
                le nombre de doigts qu'il ouvre, déterminer celui qu'il suppose que 
                son adversaire ouvre en même temps, et faire la somme. Non seulement 
                les deux premières de ces opérations supposent de la finesse 
                psychologique, la première, pour déjouer l'adversaire, et la seconde, 
                pour le pénétrer; mais encore les coups se succèdent avec une grande 
                rapidité, souvent avec des intervalles de moins d'une seconde, et 
                pourtant chaque joueur a le plus grand intérêt à contrôler chaque 
                coup. Il faut donc avoir l'œil aussi bien que l'esprit en alerte, 
                d'autant plus que si celui qui gagne ne s'en aperçoit pas, son 
                adversaire se gardera bien de le lui dire.

                J.J.M. de Groot 'Les Fêtes Annuellement Célébrées à Émoui', page 496. 
                Published 1886, reprint 1977.
                http://lenculus.mirror.k0nsl.org/___Collection%20Chine%20ancienne__%20473__/Groot%2C%20J.%20J.%20M%20de%20-%20Les%20f%C3%AAtes%20annuellement%20c%C3%A9l%C3%A9br%C3%A9es%20%C3%A0%20%C3%89moui.%20Les%20deux%20volumes%20en%20un.pdf


Source:     http://www.appalachianhistory.net/2011/09/only-play-this-game-with-honest-man.html
            http://www.perseus.tufts.edu/hopper/morph?l=Micare&la=la#lexicon
            Anthony Rich: A Dictionary of Roman and Greek Antiquities: Micatio or digitis micare, page 422–423 with Nearly 2000 Engravings on Wood from Ancient Originals. Published 1884 or 1893.
            http://www.archive.org/stream/adictionaryroma00richgoog#page/n429/mode/2up
            https://archive.org/download/adictionaryroma00richgoog/adictionaryroma00richgoog.pdf
            https://archive.org/stream/adictionaryroma00richgoog/adictionaryroma00richgoog_djvu.txt
            J.J.M. de Groot 'Les Fêtes Annuellement Célébrées à Émoui', page 496. Published 1886, reprint 1977.
            http://lenculus.mirror.k0nsl.org/___Collection%20Chine%20ancienne__%20473__/Groot%2C%20J.%20J.%20M%20de%20-%20Les%20f%C3%AAtes%20annuellement%20c%C3%A9l%C3%A9br%C3%A9es%20%C3%A0%20%C3%89moui.%20Les%20deux%20volumes%20en%20un.pdf


___________________________


  ____  _ _     _ _                             _
 |  _ \(_) |   | (_)                           | |
 | |_) |_| |__ | |_  ___   __ _ _ __ __ _ _ __ | |__  _   _
 |  _ <| | '_ \| | |/ _ \ / _` | '__/ _` | '_ \| '_ \| | | |
 | |_) | | |_) | | | (_) | (_| | | | (_| | |_) | | | | |_| |
 |____/|_|_.__/|_|_|\___/ \__, |_|  \__,_| .__/|_| |_|\__, |
                           __/ |         | |           __/ |
                          |___/          |_|          |___/

Bibliography:


de Groot, J.J.M. (1886):    'Les Fêtes Annuellement Célébrées à Émoui', page 496. Published 1886, reprint 1977.
                            http://lenculus.mirror.k0nsl.org/___Collection%20Chine%20ancienne__%20473__/Groot%2C%20J.%20J.%20M%20de%20-%20Les%20f%C3%AAtes%20annuellement%20c%C3%A9l%C3%A9br%C3%A9es%20%C3%A0%20%C3%89moui.%20Les%20deux%20volumes%20en%20un.pdf

Linhart, Sepp and Sabine Frühstück (1998):    'The Culture of Japan as Seen through Its Leisure'
                                              https://books.google.com/books?id=k_Cb7a6FQwwC&pg=PA325

Linhart, Sepp (1995):   'Some Thoughts on the Ken Game in Japan: From the Viewpoint of Comparative Civilization Studies.' 
                        Senri Ethnological Studies 40: 101-124. http://tinyurl.com/zju37c2
                        https://minpaku.repo.nii.ac.jp/?action=pages_view_main&active_action=repository_view_main_item_detail&item_id=3017&item_no=1&page_id=13&block_id=21

Rich, Anthony (1893):   'A Dictionary of Roman and Greek Antiquities': Micatio or digitis micare, page 422–423 with Nearly 2000 Engravings on Wood from Ancient Originals. Published 1884 or 1893.
                        http://www.archive.org/stream/adictionaryroma00richgoog#page/n429/mode/2up
                        https://archive.org/download/adictionaryroma00richgoog/adictionaryroma00richgoog.pdf
                        https://archive.org/stream/adictionaryroma00richgoog/adictionaryroma00richgoog_djvu.txt

Smith, William (1849):  Dictionary of Greek and Roman Biography and Mythology Published 1849.
                        https://archive.org/stream/adictionarygree00smitgoog/adictionarygree00smitgoog_djvu.txt
                        https://ia800304.us.archive.org/0/items/adictionarygree00smitgoog/adictionarygree00smitgoog.pdf



   _____
  / ____|
 | (___   ___  _   _ _ __ ___ ___
  \___ \ / _ \| | | | '__/ __/ _ \
  ____) | (_) | |_| | | | (_|  __/
 |_____/ \___/ \__,_|_|  \___\___|


https://community.spiceworks.com/scripts/show/1712-start-countdown                            # Martin Pugh: "Start-Countdown"
http://stackoverflow.com/questions/10941756/powershell-show-elapsed-time                      # Jeff: "Powershell show elapsed time"



  _    _      _
 | |  | |    | |
 | |__| | ___| |_ __
 |  __  |/ _ \ | '_ \
 | |  | |  __/ | |_) |
 |_|  |_|\___|_| .__/
               | |
               |_|
#>

<#

.SYNOPSIS
Play the 'Rock-paper-scissors' -game, or the Chinese game called 'Shoushiling' or
the Japanese game called 'Mushi-ken' or the ancient Roman game called 'Micare
Digitis'.

.DESCRIPTION
The regular action in the Rock-Paper-Scissors is to play the 'Rock-paper-scissors'
-game (or 'Stone-paper-scissors' -game). The result of a round of 'Rock-paper-
scissors' is displayed in console after the user settable amount of delay (defined
in milliseconds with the parameter -Delay, which has the aliases called -Wait and
-Pause).

To play a round of the Chinese game called 'Shoushiling', a parameter -Chinese may
be used in the command. To play a round of the Japanese game called 'Mushi-ken',
a parameter -Japanese may be used in the command. To play a round of the ancient
Roman game called 'Micare Digitis', a parameter -Roman may be used in the command.

To read more about the origins of each game, please see the History section (in the
source code comments since Windows PowerShell doesn't work very well when trying to
display the non-ascii characters).

To see the the rules of a game, a parameter -Help (which has the aliases of -Text
and -Definition and -Rules) may be added to each and every command. The definitions
of each game are decribed in the Description section below. To hear the result in
code language, an -Audio parameter may be added to the command.

.PARAMETER Chinese
To play a round of the Chinese game called 'Shoushiling', a parameter -Chinese may
be used in the command.

.PARAMETER Japanese
To play a round of the Japanese game called 'Mushi-ken', a parameter -Japanese may
be used in the command.

.PARAMETER Roman
To play a round of the ancient Roman game called 'Micare Digitis', a parameter
-Roman may be used in the command.

.PARAMETER Delay
The result of a 'Rock-Paper-Scissors' -game is displayed in console after the user
settable amount of delay (defined in milliseconds with the parameter -Delay, which
has the aliases called -Wait and -Pause). The value should be an integer between
0 and ten billion. All values under 1000 (one second) are shown without a progress
bar, and for instance, a value of 750 results in a slower pace without any progress
bars and a value of 178 is a reasonable responsive UX without any progress bars.
The default value is 3030, which shows the result after roughly three seconds and
displays a progress bar to count down the time and equals to three pre-steps
(primes) i.e. 3-2-1-signal. To get the result instantly, please set the value of
parameter -Delay to number zero (-Delay 0). To get the result after two pre-steps, 
(primes) i.e. 2-1-signal, please set the value of -Delay parameter between 2000 
and 2499 (where the value above 2000 is defining, how long should it take, before 
the countdown from two commences). The threshold level for the delay, above which 
additional instructions to cancel the countdown are displayed is defined on line 
29 with the $delay_notify_threshold variable (in milliseconds). The usage of 
fractions of milliseconds with the -Delay parameter is not supported.

.PARAMETER Help
To see the the rules of a game, a parameter -Help (which has the aliases of -Text
and -Definition and -Rules) may be added to each and every command.

.PARAMETER Audio
If the -Audio parameter is used in the command, after the results have been displayed
a morse code character e (one beep) or a morse code character s (three beeps) or a
morse code character 5 (five beeps) is emitted through the speakers and in the case
of 'Micare Digitis', the number of beeps equals the number of fingers the opponent
is showing. The default audio mode in Rock-Paper-Scissors is "silent". To find out,
which sound is emitted when, please see the table below.


        'Rock-paper-scissors' and 'Shoushiling' and 'Mushi-ken'


    Morse Code Character e      Morse Code Character s       Morse Code Character 5
    ----------------------      ----------------------       ----------------------
          [one beep]                [three beeps]                 [five beeps]

       Rock                          Paper                         Scissors
       Slug (namekuji)               Snake (hebi)                  Frog (kawazu)
       Centipede (wu)                Snake (she)                   Frog (wa)


                                ~OR~


                          'Micare Digitis'


    No fingers      1 Finger    2 Fingers    3 Fingers      4 Fingers     5 Fingers
    ----------      --------    ---------    ---------      ---------     ---------
    [silent]        [one beep]  [two beeps]  [three beeps]  [four beeps]  [five beeps]


.OUTPUTS
Generates an output of a selected game in console. Displays a progress bar, if
-Delay is set over 1000 (one second). Emits a sound, if -Audio parameter is used.

.NOTES
Please note that each of the parameters can be "tab completed" before typing them
fully (by pressing the [tab] key, not including the aliases).

Please note that only one game type at a time (-Chinese, -Japanese, -Roman or 
'Rock-paper-scissors') may be selected to play in one round due to the radically 
different nature of the games.

Please see the Description section below for definitions of each game.


    Description


    (1) 'Rock-paper-        "In 'Rock-paper-scissors' (or 'Stone-paper-scissors')
        scissors'           each participant shows one of the three hand signals
                            after a synchronized countdown, which consists of two or
                            three pre-steps (i.e. 3-2-1-signal or 2-1-signal), has
                            elapsed. It is essential for the flow of the game for
                            all participants (1) to know the number of pre-steps,
                            for them to be certain, will the signal be released on
                            third or fourth count and (2) then to be in the same
                            rhythm before the handsigns are signalled. If at any
                            time the players are not in synch with their pre-steps
                            (primes), it is recommended to restart the game, since
                            having players deliver their throw at the same time is
                            critical in ensuring a fair match. For fairness of the
                            play, it is recommended to agree on the number of rounds
                            to be played before the playing begins, so that each
                            participant will know whether the outcome will be
                            decided in one go or whether the game is in a tournament
                            mode (best out of [uneven_number_of_rounds]). The
                            released hand signs each have an inherent value in which
                            one sign will always be better than the released hand
                            sign and another hand sign will be worse than the
                            released hand sign - furthermore it is ordained that all
                            the signs together are valued successively so that they
                            form an 'Infinite Loop of Betterness'. In 'Rock-paper
                            -scissors' this loop is formed by valuing the hand
                            signals as follows: 'Rock wins against Scissors,
                            Scissors wins against Paper and Paper wins against Rock'
                            or in a negative tone: 'Rock loses against Paper, Paper
                            loses against Scissors and Scissors loses against Rock'.
                            In 'Rock-paper-scissors' ties, where the participants
                            show the same hand signal as a result, per se, cannot be
                            broken, but the occured 'Tie-Break Situation' is usually
                            resolved by playing another round of 'Rock-paper-scissors'
                            immediately after the existence of 'Tie-Break Situation'
                            has been confirmed."

                            "In 'Rock-paper-scissors' it is customary to use the
                            closed fist when signalling the 'Rock' (where the wrist
                            is positioned similarly as to holding a glass full of
                            water (and the fingers are closed together) with the
                            thumb resting about at the same height as the topmost
                            finger of the hand. The thumb is usually not concealed
                            by the fingers), the open horizontal flat hand palm
                            facing down when signalling the 'Paper' (which is
                            delivered in the same manner as rock with the exception
                            that all fingers including the thumb are fully extended
                            and horizontal with the points of the fingers facing the
                            opposing player) and a fist with the index and middle
                            fingers forming a vertical V when signalling the
                            'Scissors' (which is delivered in the same manner as
                            rock with the exception that the index and middle
                            fingers are fully extended toward the opposing player.
                            It is considered good form to angle the topmost finger
                            upwards and the lower finger downwards in order to
                            create a roughly 30-45 degree angle between the two
                            digits and thus mimic a pair of scissors)."
                            Source: http://worldrps.com/game-basics/


    (2) 'Shoushiling'       "In 'Shoushiling' (literally: 'hand command') each
                            participant shows one of the three hand signals after a
                            synchronized countdown, which consists of one to three
                            pre-steps (i.e. 1-signal to 3-2-1-signal), has elapsed.
                            It is essential for the flow of the game for all
                            participants (1) to know the number of pre-steps, for
                            them to be certain, on which count the signal shall be
                            released and (2) then to be in the same rhythm before
                            the handsigns are signalled. If at any time the players
                            are not in synch with their pre-steps (primes), it is
                            recommended to restart the game, since having players
                            deliver their throw at the same time is critical in
                            ensuring a fair match. For fairness of the play, it is
                            recommended to agree on the number of rounds to be
                            played before the playing begins, so that each
                            participant will know whether the outcome will be
                            decided in one go or whether the game is in a tournament
                            mode (best out of [uneven_number_of_rounds]). The
                            released hand signs each have an inherent value in which
                            one sign will always be better than the released hand
                            sign and another hand sign will be worse than the
                            released hand sign - furthermore it is ordained that all
                            the signs together are valued successively so that they
                            form an 'Infinite Loop of Betterness'. In 'Shoushiling'
                            this loop is formed by valuing the hand signals as
                            follows: 'Centipede (wu) wins against Snake (she),
                            Snake (she) wins against Frog (wa) and Frog (wa) wins
                            against Centipede (wu)' or in a negative tone:
                            'Centipede (wu) loses against Frog (wa), Frog (wa) loses
                            against Snake (she) and Snake (she) loses against
                            Centipede (wu)'. In 'Shoushiling' ties, where the
                            participants show the same hand signal as a result,
                            per se, cannot be broken, but the occured 'Tie-Break
                            Situation' is usually resolved by playing another round
                            of 'Shoushiling' immediately after the existence of
                            'Tie-Break Situation' has been confirmed."

                            "In 'Shoushiling' the signal code language differs from
                            its Western counterparts, and in 'Shoushiling' it is
                            customary to use the little (pinky) finger when
                            signalling the 'Centipede'(wu), the index finger when
                            signalling the 'Snake' (she) and the thumb when
                            signalling the 'Frog' (wa)."
                            Source: http://www.historyofemotions.org.au/media/230620/2015-zest-education-pack-final-web-version.pdf & Linhart, Sepp (1995). 'Some Thoughts on the Ken Game in Japan: From the Viewpoint of Comparative Civilization Studies. Senri Ethnological Studies 40: 101-124. http://tinyurl.com/zju37c2


    (3) 'Mushi-ken'         "In 'Mushi-ken' (ken ('fist') of the small animals, one
                            of the games of 'sansukumi-ken' (ken ('fist') of the
                            three who are afraid of one another)) each participant
                            shows one of the three hand signals after a synchronized
                            countdown, which consists of one to three pre-steps
                            (i.e. 1-signal to 3-2-1-signal), has elapsed. It is
                            essential for the flow of the game for all participants
                            (1) to know the number of pre-steps, for them to be
                            certain, on which count the signal shall be released and
                            (2) then to be in the same rhythm before the handsigns
                            are signalled. If at any time the players are not in
                            synch with their pre-steps (primes), it is recommended
                            to restart the game, since having players deliver their
                            throw at the same time is critical in ensuring a fair
                            match. For fairness of the play, it is recommended to
                            agree on the number of rounds to be played before the
                            playing begins, so that each participant will know
                            whether the outcome will be decided in one go or whether
                            the game is in a tournament mode (best out of
                            [uneven_number_of_rounds]). The released hand signs each
                            have an inherent value in which one sign will always be
                            better than the released hand sign and another hand sign
                            will be worse than the released hand sign - furthermore
                            it is ordained that all the signs together are valued
                            successively so that they form an 'Infinite Loop of
                            Betterness'. In 'Mushi-ken' this loop is formed by
                            valuing the hand signals as follows:
                            'Slug (namekuji / namekujiri, a shell-less 'snail') wins
                            against Snake (hebi), Snake (hebi) wins against
                            Frog (kawazu) and Frog (kawazu) wins against
                            Slug (namekuji)' or in a negative tone: 'Slug (namekuji)
                            loses against Frog (kawazu), Frog (kawazu) loses against
                            Snake (hebi) and Snake (hebi) loses against
                            Slug (namekuji)'. In 'Mushi-ken' ties, where the
                            participants show the same hand signal as a result,
                            per se, cannot be broken, but the occured 'Tie-Break
                            Situation' is usually resolved by playing another round
                            of 'Mushi-ken' immediately after the existence of
                            'Tie-Break Situation' has been confirmed."

                            "In 'Mushi-ken' the signal code language differs from
                            its Western counterparts, and in 'Mushi-ken' it is
                            customary to use the little (pinky) finger when
                            signalling the 'Slug' (namekuji), the index finger when
                            signalling the 'Snake' (hebi) and the thumb when
                            signalling the 'Frog' (kawazu (modern: kaeru)).
                            Movements are performed very quickly, and the game is
                            usually played until three or five wins. The game is
                            customarily played only with right hand while the left
                            hand was used to count the wins. The participants could
                            also follow the alternated ritus of Jan-ken Style, where
                            both participants start by saying 'Saisho (wa) guu'
                            (Starting with a rock), and after holding out a closed
                            fist raise their primary hand slightly, and follow it
                            with 'janken pon!' simultaneously throwing out their
                            move, whether it's a slug, snake or frog. If there's a
                            tie (a draw or 'aiko', if both participants chose the
                            same move), they say 'Aiko desho!' (It seems like a
                            tie!) and repeat the ritual 'Saisho guu, janken pon'
                            in an almost trance-like rapid-fire succession until
                            one player (finally) wins."
                            Source: https://japandaily.jp/decision-making-powers-janken-2626/ & Linhart, Sepp, and Sabine Frühstück: 'The Culture of Japan as Seen through Its Leisure': https://books.google.com/books?id=k_Cb7a6FQwwC&pg=PA325


    (4) 'Micare Digitis'    "In 'Micare Digitis' (Flashing of Fingers) each
                            participant shows zero to five fingers after a
                            synchronized countdown, which consists of one to three
                            pre-steps (i.e. 1-signal to 3-2-1-signal), has elapsed.
                            It is essential for the flow of the game for all
                            participants (1) to know the number of pre-steps, for
                            them to be certain, on which count the finger(s) shall
                            be shown and (2) then to be in the same rhythm before
                            the handsign is signalled. If at any time the players
                            are not in synch with their pre-steps (primes), it is
                            recommended to restart the game, since having players
                            deliver their throw at the same time is critical in
                            ensuring a fair match. For fairness of the play, it is
                            recommended to agree before the playing begins on the
                            number of rounds a participant must guess correctly (or
                            points achieve) in order to win the match ('Micare
                            Digitis' is usually played in a tournament-mode). In
                            'Micare Digitis' at the same time when a hand sign is
                            signalled also a number, which should represent the
                            participants guess of the total number of fingers shown
                            on the current round, is pronounced (usually a number
                            ranging from zero to ten is uttered). This guess is
                            validated correct or false by the total number of
                            fingers that can be seen. In 'Micare Digitis' ties
                            (draws), where the participants pronounce the same
                            number as a result that is validated as correct, per se,
                            cannot be broken, but the occured 'Tie-Break Situation'
                            is usually resolved by playing another round of 'Micare
                            Digitis' immediately after the existence of 'Tie-Break
                            Situation' has been confirmed. After each round,
                            however, the fingers are counted to see, if anyone
                            guessed the total number of fingers correctly. If one of
                            the participants guessed correctly, that person wins the
                            round, and one point is awarded to that (lucky) player.
                            If no one guessed the right number then nobody wins that
                            round, and no points are awarded for that round. If all
                            participants guessed the correct answer, then it is a
                            draw ('Tie-Break Situation') and nobody gets credit for
                            winning the round, and no points are awarded for that
                            round. The play continues until one of the participants
                            reaches the number of rounds won (or points) needed to
                            win the match."

                            "In 'Micare Digitis' the hand-signs are signalled with a
                            primary hand (by extending the fingers, if any), while
                            the secondary hand is kept out of sight, usually behind
                            one's back. The secondary hand is usually used to count
                            the current personal score (i.e. the number of rounds
                            won). In 'Micare Digitis', when signalling the number
                            three, it might be customary to use a similar hand sign 
                            to what is seen some of the NBA referees using while 
                            indicating a three-point-shot-attempt, where index 
                            finger is curved beside the thumb while the last three 
                            digits remain straight. When signalling the 'Zero' or 
                            'no fingers' in 'Micare Digitis', the extended hand is 
                            accompanied with a closed fist in a similar fashion to 
                            the 'Rock' in 'Rock-paper-scissors'."
                            Source: http://www.appalachianhistory.net/2011/09/only-play-this-game-with-honest-man.html


    Polls 


    (1) Recently, we asked thousands of people from 56 cities a simple question: 
        rock, paper, or scissors? More than 17k weighed in, and their answers 
        may surprise you.

                USA: n=17000

                Rock        Paper       Scissors
                ----        -----       --------
                57 %        28 %          15 %

                https://www.groupon.com/articles/rock-paper-or-scissors-how-to-crush-any-opponent-al




    (2) Chinese: n=354 participants, divided into groups of six and each participant
        played 300 rounds against other members of their group.

                Rock        Paper       Scissors
                ----        -----       --------
                36 %        33 %          32 %

                http://www.bbc.com/news/science-environment-27228416
                http://investorplace.com/2014/05/rock-paper-scissors-game/
                https://arxiv.org/pdf/1404.5199v1.pdf




    (3) The World Rock, Paper or Scissors Society (RPS) reports these proportions 
        (for tournament play, with mostly expert players):

                Rock        Paper       Scissors
                ----        -----       --------
                35.4 %      35.0 %       29.6 %

                http://www.telegraph.co.uk/men/thinking-man/11051704/How-to-always-win-at-rock-paper-scissors.html




    (4) British: n=45 participants, while either one or both players were 
        blindfolded, divided into groups of three and each triads were required to
        play nine matches of RPS, each comprising 20 individual rounds.

                                    Rock        Paper       Scissors
                                    ----        -----       --------
                blind–sighted       32.1 %      33.1 %       34.8 %
                blind–blind         32.8 %      33.5 %       33.7 %
                overall             32.4 %      33.3 %       34.4 %

                http://rspb.royalsocietypublishing.org/content/279/1729/780




    Homepage:           https://github.com/auberginehill/rock-paper-scissors
                        Short URL: http://tinyurl.com/jeapk3x
    Version:            1.0


.EXAMPLE
./Rock-Paper-Scissors

Run the script. Please notice to insert ./ or .\ before the script name.
Uses the default game mode ('Rock-paper-scissors' -game) and generates the result
after the default delay time of 3030 milliseconds which equals to three pre-steps
(primes) i.e. 3-2-1-signal.

.EXAMPLE
help ./Rock-Paper-Scissors -Full
Display the help file.

.EXAMPLE
./Rock-Paper-Scissors -Help -Delay 10000
Run the script, use the default game mode ('Rock-paper-scissors') and display the
rules of 'Rock-paper-scissors' and show the result after ten seconds.

.EXAMPLE
./Rock-Paper-Scissors -Chinese -Pause 1500 -Audio
Run the script and play a round of the Chinese game called 'Shoushiling'
and display the result after an second and a half delay. Confirm the results with
an audible beeping sound, which will vary depending on the result. This command will
work, because -Pause is an alias of -Delay.

.EXAMPLE
./Rock-Paper-Scissors -Japanese -Text -Delay 0
Run the script and play a round of the Japanese game called 'Mushi-ken'
and display the rules of the Japanese game called 'Mushi-ken' and display the
result instantly without any delay. This command will work, because -Text is
an alias of -Help.

.EXAMPLE
./Rock-Paper-Scissors -Roman -Definition
Run the script and play the ancient Roman game called 'Micare Digitis' and display
the rules of the ancient Roman game called 'Micare Digitis'. Generates the result
after the default delay time of 3030 milliseconds, which equals to three pre-steps
(primes) i.e. 3-2-1-signal. This command will work, because -Definition is an alias
of -Help.

.EXAMPLE
./Rock-Paper-Scissors -Roman -Rules -Wait 5000 -Audio
Run the script, play the ancient Roman game called 'Micare Digitis' and display the
rules of the ancient Roman game called 'Micare Digitis' and don't display the
result until five seconds have passed. After the result has been shown, indicate
the number of how many fingers the opponent is showing by emitting the same amount
of beeps. This command will work, because -Rules is an alias of -Help and -Wait is
an alias of -Delay.

.EXAMPLE
Set-ExecutionPolicy remotesigned

This command is altering the Windows PowerShell rights to enable script execution. Windows PowerShell
has to be run with elevated rights (run as an administrator) to actually be able to change the script
execution properties. The default value is "Set-ExecutionPolicy restricted".


    Parameters:

    Restricted      Does not load configuration files or run scripts. Restricted is the default
                    execution policy.

    AllSigned       Requires that all scripts and configuration files be signed by a trusted
                    publisher, including scripts that you write on the local computer.

    RemoteSigned    Requires that all scripts and configuration files downloaded from the Internet
                    be signed by a trusted publisher.

    Unrestricted    Loads all configuration files and runs all scripts. If you run an unsigned
                    script that was downloaded from the Internet, you are prompted for permission
                    before it runs.

    Bypass          Nothing is blocked and there are no warnings or prompts.

    Undefined       Removes the currently assigned execution policy from the current scope.
                    This parameter will not remove an execution policy that is set in a Group
                    Policy scope.


For more information, please type "help Set-ExecutionPolicy -Full" or visit
https://technet.microsoft.com/en-us/library/hh849812.aspx.

.EXAMPLE
New-Item -ItemType File -Path C:\Temp\Rock-Paper-Scissors.ps1

Creates an empty ps1-file to the C:\Temp directory. The New-Item cmdlet has an inherent -NoClobber mode
built into it, so that the procedure will halt, if overwriting (replacing the contents) of an existing
file is about to happen. Overwriting a file with the New-Item cmdlet requires using the Force.
For more information, please type "help New-Item -Full".

.LINK
http://worldrps.com/game-basics/
http://www.historyofemotions.org.au/media/230620/2015-zest-education-pack-final-web-version.pdf
https://minpaku.repo.nii.ac.jp/?action=pages_view_main&active_action=repository_view_main_item_detail&item_id=3017&item_no=1&page_id=13&block_id=21
https://books.google.com/books?id=k_Cb7a6FQwwC&pg=PA325
https://japandaily.jp/decision-making-powers-janken-2626/
http://www.perseus.tufts.edu/hopper/morph?l=Micare&la=la#lexicon
http://www.appalachianhistory.net/2011/09/only-play-this-game-with-honest-man.html
http://www.straightdope.com/columns/read/1936/whats-the-origin-of-rock-paper-scissors
http://www.gutenberg.org/files/47001/47001-h/47001-h.htm
https://ia601403.us.archive.org/27/items/mtulliuscicerod00cicegoog/mtulliuscicerod00cicegoog.pdf
http://www.thelatinlibrary.com/petronius1.html
http://www.sacred-texts.com/cla/petro/satyr/sat08.htm#XLIV
http://www.forumromanum.org/literature/menippeae.html
https://archive.org/stream/satiraeetliberpr00petruoft/satiraeetliberpr00petruoft_djvu.txt
https://archive.org/stream/mterentiusvarro00oehlgoog/mterentiusvarro00oehlgoog_djvu.txt
http://www.philological.bham.ac.uk/polyadag/1alat.html
https://community.spiceworks.com/scripts/show/1712-start-countdown
http://stackoverflow.com/questions/10941756/powershell-show-elapsed-time
https://technet.microsoft.com/en-us/library/hh847743.aspx
http://poshcode.org/1192
https://technet.microsoft.com/en-us/library/hh847796.aspx
https://technet.microsoft.com/en-us/magazine/hh360993.aspx
https://technet.microsoft.com/en-us/library/ee692803.aspx

#>
