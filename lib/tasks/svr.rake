namespace :svr do
  desc "TODO"
  task stop: :environment do
    pid_file = 'tmp/pids/server.pid'
    pid = File.read(pid_file).to_i
    Process.kill 9, pid
    File.delete pid_file
    puts ''
    puts ''
    puts '                                                              _( (~\'
    puts '       _ _                        /                          ( \> > \'
    puts '   -/~/ / ~\                     :;                \       _  > /(~\/'
    puts '  || | | /\ ;\                   |l      _____     |;     ( \/    > >'
    puts '  _\\)\)\)/ ;;;                  `8o __-~     ~\   d|      \      //'
    puts ' ///(())(__/~;;\                  "88p;.  -. _\_;.oP        (_._/ /'
    puts '(((__   __ \\   \                  `>,% (\  (\./)8"         ;:'  i'
    puts ')))--`.'-- (( ;,8 \               ,;%%%:  ./V^^^V'          ;.   ;.'
    puts '((\   |   /)) .,88  `: ..,,;;;;,-::::::'_::\   ||\         ;[8:   ;'
    puts ' )|  ~-~  |(|(888; ..``'::::8888oooooo.  :\`^^^/,,~--._    |88::  |'
    puts ' |\ -===- /|  \8;; ``:.      oo.8888888888:`((( o.ooo8888Oo;:;:'  |'
    puts ' |_~-___-~_|   `-\.   `        `o`88888888b` )) 888b88888P""'     ;'
    puts ' ; ~~~~;~~         "`--_`.       b`888888888;(.,"888b888"  ..::;-''
    puts '   ;      ;              ~"-....  b`8888888:::::.`8888. .:;;;'''
    puts '      ;    ;                 `:::. `:::OOO:::::::.`OO' ;;;'''
    puts ' :       ;                     `.      "``::::::''    .''
    puts '    ;                           `.   \_              /'
    puts '  ;       ;                       +:   ~~--  `:'  -';'
    puts '                                   `:         : .::/  
    puts '      ;                            ;;+_  :::. :..;;;  
    puts '                                   ;;;;;;,;;;;;;;;,;'
    puts ''
    puts 'Server has been killed ^_^'
  end

end
