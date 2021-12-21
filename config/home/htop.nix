{ config, pkgs, ... }:

/*
fields=0 48 17 18 38 39 40 2 46 47 49 1
sort_key=49
sort_direction=-1
tree_sort_key=46
tree_sort_direction=1
hide_kernel_threads=1
hide_userland_threads=1
shadow_other_users=0
show_thread_names=0
show_program_path=0
highlight_base_name=1
highlight_megabytes=1
highlight_threads=1
highlight_changes=0
highlight_changes_delay_secs=5
find_comm_in_cmdline=1
strip_exe_from_cmdline=1
show_merged_command=0
tree_view=0
tree_view_always_by_pid=0
header_margin=1
detailed_cpu_time=0
cpu_count_from_one=1
show_cpu_usage=1
show_cpu_frequency=0
show_cpu_temperature=0
degree_fahrenheit=0
update_process_names=0
account_guest_in_cpu_meter=0
color_scheme=0
enable_mouse=1
delay=20
left_meters=LeftCPUs2 CPU Battery Blank Blank Blank Memory NetworkIO DiskIO
left_meter_modes=1 1 1 2 2 2 3 4 4
right_meters=RightCPUs2 Memory Swap Blank Blank Blank LoadAverage Uptime Tasks
right_meter_modes=1 1 1 2 2 2 3 4 4
hide_function_bar=0
*/
{
  programs.htop = {
    enable = true;
    settings = {
      color_scheme = 0;
      fields = with config.lib.htop.fields; [
        PID
        USER
        PRIORITY
        NICE
        M_SIZE
        M_RESIDENT
        M_SHARE
        STATE
        PERCENT_CPU
        PERCENT_MEM
        TIME
        COMM
      ];
      highlight_base_name = 1;
      highlight_megabytes = 1;
      highlight_threads = 1;
      enable_mouse = 1;
      show_cpu_frequency = 1;
      show_cpu_temperature = 1;
      header_margin = 1;
      tree_sort_direction = 1;
    } // (with config.lib.htop; leftMeters [
        (bar "AllCPUs")
        (bar "CPU")
        (bar "NetworkIO")
        (bar "DiskIO")
    ]) // (with config.lib.htop; rightMeters [
        (bar "Battery")
        (bar "Memory")
        (bar "Swap")
        (text "Clock")
        (text "uptime")
    ]);
  };
}