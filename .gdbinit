# no more 'type <return> to continue ...'
set pagination off

define reset
    # reset board by setting the SYSRESETREQ bit it the AIRCR register
    # see http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0552a/Cihehdge.html
    set *(0xE000ED0C) = 0x05fa0004
end

define load-reset
    reset
    load
    reset
end

define lr
    load-reset
end

define lrc
    reset
    load
    reset
    continue
end

define semihosting-enable
  source semihosting.py
  catch signal SIGTRAP
  commands
      silent
      pi SemiHostHelper.on_break()
      set $pc = $pc + 2
      if $do_continue
        continue
      end
  end
end

semihosting-enable
