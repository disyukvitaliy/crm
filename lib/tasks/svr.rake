namespace :svr do
  desc "TODO"
  task stop: :environment do
    pid_file = 'tmp/pids/server.pid'
    pid = File.read(pid_file).to_i
    Process.kill 9, pid
    File.delete pid_file
    answer = %q[
      ''
      ''
      '                                                              _( (~\'
      '       _ _                        /                          ( \> > \'
      '   -/~/ / ~\                     :;                \       _  > /(~\/'
      '  || | | /\ ;\                   |l      _____     |;     ( \/    > >'
      '  _\\)\)\)/ ;;;                  `8o __-~     ~\   d|      \      //'
      ' ///(())(__/~;;\                  "88p;.  -. _\_;.oP        (_._/ /'
      '(((__   __ \\   \                  `>,% (\  (\./)8"         ;:'  i'
      ')))--`.'-- (( ;,8 \               ,;%%%:  ./V^^^V'          ;.   ;.'
      '((\   |   /)) .,88  `: ..,,;;;;,-::::::'_::\   ||\         ;(8:   ;'
      ' )|  ~-~  |(|(888; ..``'::::8888oooooo.  :\`^^^/,,~--._    |88::  |'
      ' |\ -===- /|  \8;; ``:.      oo.8888888888:`((( o.ooo8888Oo;:;:'  |'
      ' |_~-___-~_|   `-\.   `        `o`88888888b` )) 888b88888P""'     ;'
      ' ; ~~~~;~~         "`--_`.       b`888888888;(.,"888b888"  ..::;-''
      '   ;      ;              ~"-....  b`8888888:::::.`8888. .:;;;'''
      '      ;    ;                 `:::. `:::OOO:::::::.`OO' ;;;'''
      ' :       ;                     `.      "``::::::''    .''
      '    ;                           `.   \_              /'
      '  ;       ;                       +:   ~~--  `:'  -';'
      '                                   `:         : .::/
      '      ;                            ;;+_  :::. :..;;;
      '                                   ;;;;;;,;;;;;;;;,;'
      ''
      'Server has been killed ^_^'
    ]
    puts answer
  end

end
