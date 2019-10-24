module Mixins
  module MoreShowActions
    def show_timeline
      @showtype = "timeline"
      @layout = 'timeline'
      session[:tl_record_id] = params[:id] if params[:id]
      @lastaction = "show_timeline"
      @timeline = @timeline_filter = true
      tl_build_timeline # Create the timeline report
      drop_breadcrumb(_("Timelines for %{table} \"%{name}\"") % {:table => ui_lookup(:table => controller_name), :name => @record.name})
    end

    def show_performance
      @showtype = "performance"
      display_name = @record.respond_to?(:evm_display_name) ? @record.evm_display_name : @record.name
      drop_breadcrumb(_("%{name} Capacity & Utilization") % {:name => display_name})
      perf_gen_init_options # Initialize options, charts are generated async
    end

    def show_compliance_history
      count = params[:count] ? params[:count].to_i : 10
      update_session_for_compliance_history
      drop_breadcrumb_for_compliance_history(count)
      @showtype = @display
    end

    def show_topology
      @showtype = "topology"
      drop_breadcrumb(@record.name + _(" (Topology)"))
    end

    def update_session_for_compliance_history
      @ch_tree = TreeBuilderComplianceHistory.new(:ch_tree, @sb, true, :root => @record)
    end

    def drop_breadcrumb_for_compliance_history(count)
      if count == 1
        drop_breadcrumb(_("%{name} (Latest Compliance Check)") % {:name => @record.name},
                        :url  => "/#{controller_name}/show/#{@record.id}?display=#{@display}&refresh=n")
      else
        drop_breadcrumb(_("%{name} (Compliance History - Last %{number} Checks)") % {:name => @record.name, :number => count})
      end
    end
  end
end
