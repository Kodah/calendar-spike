//
//  DispatchQueue.swift
//  Enamel
//
//  Created by Milos Rankovic on 11/04/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Dispatch

public func async(
    after delay: TimeInterval? = nil,
    on queue: DispatchQueue = .main,
    qos: DispatchQoS = .default,
    execute code: @escaping () -> Void)
{
    if let delay = delay, delay > 0 {
        queue.asyncAfter(deadline: .now() + delay, qos: qos, execute: code)
    } else {
        queue.async(execute: code)
    }
}

public func async(
    after delay: TimeInterval? = nil,
    every interval: TimeInterval,
    on queue: DispatchQueue = .main,
    qos: DispatchQoS = .default,
    iteration: Int = 1,
    continue code: @escaping (_ iteration: Int) -> Bool)
{
    async(after: delay ?? interval, on: queue, qos: qos) {
        guard code(iteration) else { return }
        async(
            every: interval,
            on: queue,
            qos: qos,
            iteration: iteration + 1,
            continue: code
        )
    }
}

public func pause(for interval: TimeInterval) {
    _ = DispatchQueue(label: "pause.queue").sync {
        usleep(useconds_t(interval * 1_000_000))
    }
}
