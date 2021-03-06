-- Persistent generated migration.

CREATE FUNCTION migrate() RETURNS void AS $$
DECLARE
  next_version int ;
BEGIN
  SELECT stage_two + 1 INTO next_version FROM schema_version ;
  IF next_version = 5 THEN
    EXECUTE 'ALTER TABLE "slot_leader" DROP CONSTRAINT "slot_leader_pool_hash_id_fkey"' ;
    EXECUTE 'ALTER TABLE "slot_leader" ADD CONSTRAINT "slot_leader_pool_hash_id_fkey" FOREIGN KEY("pool_hash_id") REFERENCES "pool_hash"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "block" DROP CONSTRAINT "block_previous_id_fkey"' ;
    EXECUTE 'ALTER TABLE "block" ADD CONSTRAINT "block_previous_id_fkey" FOREIGN KEY("previous_id") REFERENCES "block"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "block" DROP CONSTRAINT "block_slot_leader_id_fkey"' ;
    EXECUTE 'ALTER TABLE "block" ADD CONSTRAINT "block_slot_leader_id_fkey" FOREIGN KEY("slot_leader_id") REFERENCES "slot_leader"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "tx" DROP CONSTRAINT "tx_block_id_fkey"' ;
    EXECUTE 'ALTER TABLE "tx" ADD CONSTRAINT "tx_block_id_fkey" FOREIGN KEY("block_id") REFERENCES "block"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "stake_address" DROP CONSTRAINT "stake_address_registered_tx_id_fkey"' ;
    EXECUTE 'ALTER TABLE "stake_address" ADD CONSTRAINT "stake_address_registered_tx_id_fkey" FOREIGN KEY("registered_tx_id") REFERENCES "tx"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "tx_out" DROP CONSTRAINT "tx_out_tx_id_fkey"' ;
    EXECUTE 'ALTER TABLE "tx_out" ADD CONSTRAINT "tx_out_tx_id_fkey" FOREIGN KEY("tx_id") REFERENCES "tx"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "tx_out" DROP CONSTRAINT "tx_out_stake_address_id_fkey"' ;
    EXECUTE 'ALTER TABLE "tx_out" ADD CONSTRAINT "tx_out_stake_address_id_fkey" FOREIGN KEY("stake_address_id") REFERENCES "stake_address"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "tx_in" DROP CONSTRAINT "tx_in_tx_in_id_fkey"' ;
    EXECUTE 'ALTER TABLE "tx_in" ADD CONSTRAINT "tx_in_tx_in_id_fkey" FOREIGN KEY("tx_in_id") REFERENCES "tx"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "tx_in" DROP CONSTRAINT "tx_in_tx_out_id_fkey"' ;
    EXECUTE 'ALTER TABLE "tx_in" ADD CONSTRAINT "tx_in_tx_out_id_fkey" FOREIGN KEY("tx_out_id") REFERENCES "tx"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "pool_meta_data" DROP CONSTRAINT "pool_meta_data_registered_tx_id_fkey"' ;
    EXECUTE 'ALTER TABLE "pool_meta_data" ADD CONSTRAINT "pool_meta_data_registered_tx_id_fkey" FOREIGN KEY("registered_tx_id") REFERENCES "tx"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "pool_update" DROP CONSTRAINT "pool_update_hash_id_fkey"' ;
    EXECUTE 'ALTER TABLE "pool_update" ADD CONSTRAINT "pool_update_hash_id_fkey" FOREIGN KEY("hash_id") REFERENCES "pool_hash"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "pool_update" DROP CONSTRAINT "pool_update_meta_id_fkey"' ;
    EXECUTE 'ALTER TABLE "pool_update" ADD CONSTRAINT "pool_update_meta_id_fkey" FOREIGN KEY("meta_id") REFERENCES "pool_meta_data"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "pool_update" DROP CONSTRAINT "pool_update_registered_tx_id_fkey"' ;
    EXECUTE 'ALTER TABLE "pool_update" ADD CONSTRAINT "pool_update_registered_tx_id_fkey" FOREIGN KEY("registered_tx_id") REFERENCES "tx"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "pool_owner" DROP CONSTRAINT "pool_owner_pool_hash_id_fkey"' ;
    EXECUTE 'ALTER TABLE "pool_owner" ADD CONSTRAINT "pool_owner_pool_hash_id_fkey" FOREIGN KEY("pool_hash_id") REFERENCES "pool_hash"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "pool_owner" DROP CONSTRAINT "pool_owner_registered_tx_id_fkey"' ;
    EXECUTE 'ALTER TABLE "pool_owner" ADD CONSTRAINT "pool_owner_registered_tx_id_fkey" FOREIGN KEY("registered_tx_id") REFERENCES "tx"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "pool_retire" DROP CONSTRAINT "pool_retire_hash_id_fkey"' ;
    EXECUTE 'ALTER TABLE "pool_retire" ADD CONSTRAINT "pool_retire_hash_id_fkey" FOREIGN KEY("hash_id") REFERENCES "pool_hash"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "pool_retire" DROP CONSTRAINT "pool_retire_announced_tx_id_fkey"' ;
    EXECUTE 'ALTER TABLE "pool_retire" ADD CONSTRAINT "pool_retire_announced_tx_id_fkey" FOREIGN KEY("announced_tx_id") REFERENCES "tx"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "pool_relay" DROP CONSTRAINT "pool_relay_update_id_fkey"' ;
    EXECUTE 'ALTER TABLE "pool_relay" ADD CONSTRAINT "pool_relay_update_id_fkey" FOREIGN KEY("update_id") REFERENCES "pool_update"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "reserve" DROP CONSTRAINT "reserve_addr_id_fkey"' ;
    EXECUTE 'ALTER TABLE "reserve" ADD CONSTRAINT "reserve_addr_id_fkey" FOREIGN KEY("addr_id") REFERENCES "stake_address"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "reserve" DROP CONSTRAINT "reserve_tx_id_fkey"' ;
    EXECUTE 'ALTER TABLE "reserve" ADD CONSTRAINT "reserve_tx_id_fkey" FOREIGN KEY("tx_id") REFERENCES "tx"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "withdrawal" DROP CONSTRAINT "withdrawal_addr_id_fkey"' ;
    EXECUTE 'ALTER TABLE "withdrawal" ADD CONSTRAINT "withdrawal_addr_id_fkey" FOREIGN KEY("addr_id") REFERENCES "stake_address"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "withdrawal" DROP CONSTRAINT "withdrawal_tx_id_fkey"' ;
    EXECUTE 'ALTER TABLE "withdrawal" ADD CONSTRAINT "withdrawal_tx_id_fkey" FOREIGN KEY("tx_id") REFERENCES "tx"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "delegation" DROP CONSTRAINT "delegation_addr_id_fkey"' ;
    EXECUTE 'ALTER TABLE "delegation" ADD CONSTRAINT "delegation_addr_id_fkey" FOREIGN KEY("addr_id") REFERENCES "stake_address"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "delegation" DROP CONSTRAINT "delegation_pool_hash_id_fkey"' ;
    EXECUTE 'ALTER TABLE "delegation" ADD CONSTRAINT "delegation_pool_hash_id_fkey" FOREIGN KEY("pool_hash_id") REFERENCES "pool_hash"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "delegation" DROP CONSTRAINT "delegation_tx_id_fkey"' ;
    EXECUTE 'ALTER TABLE "delegation" ADD CONSTRAINT "delegation_tx_id_fkey" FOREIGN KEY("tx_id") REFERENCES "tx"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "stake_registration" DROP CONSTRAINT "stake_registration_addr_id_fkey"' ;
    EXECUTE 'ALTER TABLE "stake_registration" ADD CONSTRAINT "stake_registration_addr_id_fkey" FOREIGN KEY("addr_id") REFERENCES "stake_address"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "stake_registration" DROP CONSTRAINT "stake_registration_tx_id_fkey"' ;
    EXECUTE 'ALTER TABLE "stake_registration" ADD CONSTRAINT "stake_registration_tx_id_fkey" FOREIGN KEY("tx_id") REFERENCES "tx"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "stake_deregistration" DROP CONSTRAINT "stake_deregistration_addr_id_fkey"' ;
    EXECUTE 'ALTER TABLE "stake_deregistration" ADD CONSTRAINT "stake_deregistration_addr_id_fkey" FOREIGN KEY("addr_id") REFERENCES "stake_address"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "stake_deregistration" DROP CONSTRAINT "stake_deregistration_tx_id_fkey"' ;
    EXECUTE 'ALTER TABLE "stake_deregistration" ADD CONSTRAINT "stake_deregistration_tx_id_fkey" FOREIGN KEY("tx_id") REFERENCES "tx"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "tx_metadata" DROP CONSTRAINT "tx_metadata_tx_id_fkey"' ;
    EXECUTE 'ALTER TABLE "tx_metadata" ADD CONSTRAINT "tx_metadata_tx_id_fkey" FOREIGN KEY("tx_id") REFERENCES "tx"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "reward" DROP CONSTRAINT "reward_pool_id_fkey"' ;
    EXECUTE 'ALTER TABLE "reward" ADD CONSTRAINT "reward_pool_id_fkey" FOREIGN KEY("pool_id") REFERENCES "pool_hash"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "reward" DROP CONSTRAINT "reward_block_id_fkey"' ;
    EXECUTE 'ALTER TABLE "reward" ADD CONSTRAINT "reward_block_id_fkey" FOREIGN KEY("block_id") REFERENCES "block"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "epoch_stake" DROP CONSTRAINT "epoch_stake_addr_id_fkey"' ;
    EXECUTE 'ALTER TABLE "epoch_stake" ADD CONSTRAINT "epoch_stake_addr_id_fkey" FOREIGN KEY("addr_id") REFERENCES "stake_address"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "epoch_stake" DROP CONSTRAINT "epoch_stake_pool_id_fkey"' ;
    EXECUTE 'ALTER TABLE "epoch_stake" ADD CONSTRAINT "epoch_stake_pool_id_fkey" FOREIGN KEY("pool_id") REFERENCES "pool_hash"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "epoch_stake" DROP CONSTRAINT "epoch_stake_block_id_fkey"' ;
    EXECUTE 'ALTER TABLE "epoch_stake" ADD CONSTRAINT "epoch_stake_block_id_fkey" FOREIGN KEY("block_id") REFERENCES "block"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "treasury" DROP CONSTRAINT "treasury_addr_id_fkey"' ;
    EXECUTE 'ALTER TABLE "treasury" ADD CONSTRAINT "treasury_addr_id_fkey" FOREIGN KEY("addr_id") REFERENCES "stake_address"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "param_proposal" DROP CONSTRAINT "param_proposal_registered_tx_id_fkey"' ;
    EXECUTE 'ALTER TABLE "param_proposal" ADD CONSTRAINT "param_proposal_registered_tx_id_fkey" FOREIGN KEY("registered_tx_id") REFERENCES "tx"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    EXECUTE 'ALTER TABLE "epoch_param" DROP CONSTRAINT "epoch_param_block_id_fkey"' ;
    EXECUTE 'ALTER TABLE "epoch_param" ADD CONSTRAINT "epoch_param_block_id_fkey" FOREIGN KEY("block_id") REFERENCES "block"("id") ON DELETE CASCADE  ON UPDATE RESTRICT' ;
    -- Hand written SQL statements can be added here.
    UPDATE schema_version SET stage_two = next_version ;
    RAISE NOTICE 'DB has been migrated to stage_two version %', next_version ;
  END IF ;
END ;
$$ LANGUAGE plpgsql ;

SELECT migrate() ;

DROP FUNCTION migrate() ;
