class Help < XOmBot::Plugin
  match /help (.+)/
  help "Displays information on command arguments"
  usage "help seen -- Query information about the seen command"
  usage "help help -- Displays this thing you are reading"

  def execute(m, command)
    XOmBot.plugins.each do |_,p|
      idx = p.commands.keys.map{|c| c.inspect.to_s[1..-2][/\w+/]}.index command
      if not idx.nil?
        info = p.commands[p.commands.keys[idx]]
        m.reply "[#{command}] #{info[:help]}"
        m.reply "Invoke as: #{p.commands.keys[idx].inspect.to_s[1..-2]}"
        if info[:usage]
          info[:usage].each do |usage|
            m.reply usage
          end
        end
      end
    end
  end
end
