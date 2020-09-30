//
//  MemoryMonitor.swift
//  PerformanceMonitor
//
//  Created by Himanshu Namdeo on 21/09/20.
//  Copyright © 2020 8BitArcade. All rights reserved.
//

import Foundation


class MemoryMonitor: Monitor {
    var delegate: DataCollector?
     private var timer: PMTimer?
    
    init() {
        startFetching()
    }
    
    func startFetching() {
        timer = PMTimer { (timer) in
            let memoryUsage = self.memoryFootprint()
            self.delegate?.didRecieve(data: memoryUsage as AnyObject, from: self)
        }
        timer?.start()
    }
    
    func stopFetching() {
        timer?.stop()
    }
    
    private func memoryFootprint() -> Float? {
        // The `TASK_VM_INFO_COUNT` and `TASK_VM_INFO_REV1_COUNT` macros are too
        // complex for the Swift C importer, so we have to define them ourselves.
        let TASK_VM_INFO_COUNT = mach_msg_type_number_t(MemoryLayout<task_vm_info_data_t>.size / MemoryLayout<integer_t>.size)
        let TASK_VM_INFO_REV1_COUNT = mach_msg_type_number_t(MemoryLayout.offset(of: \task_vm_info_data_t.min_address)! / MemoryLayout<integer_t>.size)
        var info = task_vm_info_data_t()
        var count = TASK_VM_INFO_COUNT
        let kr = withUnsafeMutablePointer(to: &info) { infoPtr in
            infoPtr.withMemoryRebound(to: integer_t.self, capacity: Int(count)) { intPtr in
                task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), intPtr, &count)
            }
        }
        guard
            kr == KERN_SUCCESS,
            count >= TASK_VM_INFO_REV1_COUNT
            else { return nil }

        let usedBytes = Float(info.phys_footprint)
        return usedBytes/1048576
    }

    private func formattedMemoryFootprint() -> String
    {
        let usedBytes: UInt64? = UInt64(self.memoryFootprint() ?? 0)
        let usedMB = Double(usedBytes ?? 0) / 1024 / 1024
        let usedMBAsString: String = "\(usedMB)MB"
        return usedMBAsString
     }
    
//    func report_memory() -> Int {
//        var taskInfo = mach_task_basic_info()
//        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
//        var memCountInMB = 0
//        let kerr: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
//            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
//                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
//            }
//        }
//
//        if kerr == KERN_SUCCESS {
////            print("Memory used in bytes: \(taskInfo.resident_size)")
//            memCountInMB = Int(taskInfo.resident_size/(1048576))
//        }
//        else {
//            print("Error with task_info(): " +
//                (String(cString: mach_error_string(kerr), encoding: String.Encoding.ascii) ?? "unknown error"))
//        }
//
//        return memCountInMB
//    }
}

//- (NSArray *)runningProcesses
//{
//    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
//    size_t miblen = 4;
//
//    size_t size;
//    int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
//
//    struct kinfo_proc *process = NULL;
//    struct kinfo_proc *newprocess = NULL;
//
//    do {
//        size += size / 10;
//        newprocess = realloc(process, size);
//
//        if (!newprocess) {
//            if (process) {
//                free(process);
//            }
//
//            return nil;
//        }
//
//        process = newprocess;
//        st = sysctl(mib, miblen, process, &size, NULL, 0);
//    } while (st == -1 && errno == ENOMEM);
//
//    if (st == 0) {
//        if (size % sizeof(struct kinfo_proc) == 0) {
//            int nprocess = size / sizeof(struct kinfo_proc);
//
//            if (nprocess) {
//                NSMutableArray * array = [[NSMutableArray alloc] init];
//
//                for (int i = nprocess - 1; i >= 0; i--) {
//                    NSString *processID = [[NSString alloc] initWithFormat:@"%d", process[i].kp_proc.p_pid];
//                    NSString *processName = [[NSString alloc] initWithFormat:@"%s", process[i].kp_proc.p_comm];
//
//                    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:processID, processName, nil]
//                                                                       forKeys:[NSArray arrayWithObjects:@"ProcessID", @"ProcessName", nil]];
//                    [processID release];
//                    [processName release];
//                    [array addObject:dict];
//                    [dict release];
//                }
//
//                free(process);
//                return array;
//            }
//        }
//    }
//
//    return nil;
//}
