//
//  File.swift
//  
//
//  Created by Romy Cheah on 29/5/22.
//

import Foundation

// TODO: Rewrite with MetricKit
public final class MeasurementLogger {
  private var startTime: DispatchTime?
  private var endTime: DispatchTime?

  public private(set) var executionTime: TimeInterval?

  public init() {
  }

  public func start() {
    guard startTime == nil else {
      print("[Measurement Logger] Cannot start measurement more than once")
      return
    }

    startTime = DispatchTime.now()
  }

  public func stop() {
    guard let startTime = startTime else {
      print("[Measurement Logger] start measurement logger before trying to stop it")
      return
    }

    guard endTime == nil else {
      print("[Measurement Logger] Cannot be stopped more than once")
      return
    }

    let endTime = DispatchTime.now()
    self.endTime = endTime

    let nanoTime = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
    executionTime = Double(nanoTime) / 1000000000
  }

  public func log() {
    guard let executedTime = executionTime else {
      print("[Measurement Logger] executedTime cannot be computed, please call start and stop first")
      return
    }

    print("[Measurement Logger] Execution time: \(executedTime) second(s)")
  }

  public var executedSecondsText: String? {
    guard let executedTime = executionTime else {
      print("[Measurement Logger] executedTime cannot be computed, please call start and stop first")
      return nil
    }

    return "\(executedTime) second(s)"
  }
}
